import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frame_wise/app/mvvm/model/video_models.dart';
import 'package:frame_wise/app/mvvm/view_model/project/project_controller.dart';
import 'package:frame_wise/app/services/frame_service.dart';
import 'package:frame_wise/app/services/logger_service.dart';
import 'package:frame_wise/app/services/storage_service.dart';
import 'package:frame_wise/app/services/video_services.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:crypto/crypto.dart';

class FrameAnalysisController extends GetxController {
  FrameExtractorService frameExtractorService = FrameExtractorService.instance;
  VideoServices videoServices = VideoServices.instance;
  StorageService storageService = StorageService.instance;
  final projectController = Get.find<ProjectController>();

  late VideoPlayerController videoController;
  RxBool isVideoInitialized = false.obs;
  ProjectJsonModel? currentProject;
  RxList<String> framePaths = <String>[].obs;

  RxBool loading = false.obs;
  RxBool isPlaying = false.obs;
  RxInt currentFrame = 0.obs;
  RxDouble zoom = 1.0.obs;
  RxSet<int> deletedFrames = <int>{}.obs;
  final ScrollController timelineScroll = ScrollController();
  final double frameWidth = 80;
  Timer? playheadTimer;
  final RxDouble progress = 0.0.obs;
  final RxString progressMessage = ''.obs;
  final double fps = 2.0;

  late String videoPath;
  late String projectDirPath;
  late String projectId;
  late String thumbnailPath;

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;

    LoggerService.i('arguments : $args');
    videoPath = args['videoPath'];
    projectDirPath = args['projectDirPath'];
    projectId = args['projectId'];
    thumbnailPath = args['thumbnailPath'];

    loadFrames();
    super.onInit();
  }

  Future<void> loadFrames() async {
    try {
      loading.value = true;
      progress.value = 0.0;
      progressMessage.value = "Preparing video...";

      final videoHash = projectId.split('_').last;
      LoggerService.i("Generated Video Hash: $videoHash");

      final dir = await getApplicationDocumentsDirectory();
      final frameCacheDir = Directory('${dir.path}/frame_cache/$videoHash');
      final statusFile = File('${frameCacheDir.path}/.extraction_success');
      final proxyPath = '${frameCacheDir.path}/proxy.mp4';
      final proxyFile = File(proxyPath);

      // Check : Kya folder pehle se hai?
      if (!await frameCacheDir.exists()) {
        await frameCacheDir.create(recursive: true);
      }

      // Check : Kya Proxy already bani hui hai?
      if (!await proxyFile.exists() || await proxyFile.length() == 0) {
        LoggerService.i('generating proxy video in cache ');
        progressMessage.value = "Generating proxy video...";
        final proxyVideoSuccess = await videoServices.generateProxyVideo(
          originalPath: videoPath,
          proxyPath: proxyPath,
          onProgress: (p) {
            progress.value = p * 0.5;
          },
        );

        if (proxyVideoSuccess == false) {
          throw Exception("FFmpeg could not create proxy video.");
        }
      } else {
        LoggerService.i('✅ Proxy already exists, skipping generation.');
      }

      // Check : Kya Frames extracted hain?
      if (!await statusFile.exists()) {
        LoggerService.i('extracting frames from proxy video');
        final success = await frameExtractorService.extractVideoFrames(
          proxyPath,
          frameCacheDir.path,
          (p) {
            progress.value = 0.5 + (p * 0.5);
          },
        );
        LoggerService.d('frames extraction status from proxy video : $success');
        if (success) await statusFile.create(recursive: true);
        LoggerService.d('check sttus file: ${await statusFile.exists()}');
      } else {
        LoggerService.i('✅ Frames already extracted, skipping.');
      }

      if (!await proxyFile.exists() || await proxyFile.length() == 0) {
        throw Exception('Proxy Video not reaady');
      }

      videoController = VideoPlayerController.file(proxyFile);

      await videoController.initialize();
      isVideoInitialized.value = true;
      LoggerService.d('is vidoe initialized: $isVideoInitialized');
      videoController.addListener(() {
        if (videoController.value.hasError) {
          LoggerService.e(
            'Video error: ${videoController.value.errorDescription}',
          );
        }
      });

      LoggerService.i('start frame sorting');
      final List<String> paths = await compute(
        getSortedFrames,
        frameCacheDir.path,
      );
      framePaths.assignAll(paths);

      currentProject = ProjectJsonModel(
        projectId: projectId,
        title: projectId.split('_').last,
        videoPath: videoPath,
        proxyPath: proxyPath,
        videoHash: videoHash,
        thumbnail: thumbnailPath,
        fps: 2,
        deletedFrames: deletedFrames.toList() as List,
        createdAt: DateTime.now(),
      );

      if (framePaths.isNotEmpty) {
        startTracking();
      }
    } catch (e, stack) {
      LoggerService.e("Error", error: e, stackTrace: stack);
    } finally {
      loading.value = false;
    }
  }

  Future<void> saveCurrentProject() async {
    LoggerService.i('Saving project state...');
    if (currentProject == null) {
      LoggerService.w("Project not fully loaded, skipping save.");
      return;
    }
    currentProject = ProjectJsonModel(
      projectId: currentProject!.projectId,
      title: currentProject!.title,
      videoPath: currentProject!.videoPath,
      proxyPath: currentProject!.proxyPath,
      videoHash: currentProject!.videoHash,
      thumbnail: currentProject!.thumbnail,
      fps: currentProject!.fps,
      deletedFrames: deletedFrames.toList() as List,
      createdAt: currentProject!.createdAt,
    );

    await storageService.saveProject(currentProject!, projectController);
    LoggerService.i('✅ Project Saved Successfully');
  }

  void startTracking() {
    playheadTimer?.cancel();
    playheadTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (!videoController.value.isInitialized) return;
      if (framePaths.isEmpty) return;

      final ms = videoController.value.position.inMilliseconds;

      final frameIndex = ((ms / 1000) * fps).floor().clamp(
        0,
        framePaths.length - 1,
      );
      if (frameIndex != currentFrame.value) {
        currentFrame.value = frameIndex;
        autoScroll(frameIndex);
      }
      isPlaying.value = videoController.value.isPlaying;
    });
  }

  void autoScroll(int frame) {
    final offset = (frame * frameWidth * zoom.value).toDouble();
    if (!timelineScroll.hasClients) return;
    final current = timelineScroll.offset;
    final viewport = timelineScroll.position.viewportDimension;

    if (offset < current || offset > current + viewport - frameWidth) {
      if (!timelineScroll.position.isScrollingNotifier.value) {
        timelineScroll.animateTo(
          offset,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    }
  }

  void selectFrame(int index) {
    if (framePaths.isEmpty) return;
    index = index.clamp(0, framePaths.length - 1);
    pause();
    currentFrame.value = index;
    videoController.seekTo(
      Duration(milliseconds: (index * 1000 / fps).round()),
    );

    autoScroll(index);
  }

  String getVideoDuration() {
    if (!videoController.value.isInitialized) return "00:00";

    final duration = videoController.value.duration;

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  void play() {
    videoController.play();
    isPlaying.value = true;
  }

  void pause() {
    videoController.pause();
    isPlaying.value = false;
  }

  void deleteFrame(int index) {
    if (index < 0 || index >= framePaths.length) return;
    deletedFrames.add(index);
    LoggerService.i('deleted frame: $index');
  }

  void undoDelete() {
    if (deletedFrames.isEmpty) return;
    deletedFrames.remove(deletedFrames.last);
  }

  Future<void> downloadFrame(int index) async {
    if (index < 0 || index >= framePaths.length) {
      LoggerService.e("invalid frame index: $index");
      return;
    }

    String currentFramePath = framePaths[index];
    File imageFile = File(currentFramePath);

    if (!await imageFile.exists()) {
      LoggerService.e("File not found at: $currentFramePath");
      return;
    }

    try {
      bool hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          Get.snackbar(
            "Permission Denied",
            "Please allow gallery access from settings to save frames.",
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
      }

      await Gal.putImage(currentFramePath, album: 'FrameWise');
      LoggerService.i("Frame $index saved to gallery successfully.");

      Get.snackbar(
        "Success",
        "Frame saved to Gallery (FrameWise Album)",
        snackPosition: SnackPosition.BOTTOM,
      );
    } on GalException catch (e) {
      LoggerService.e("Gal Error: ${e.type}");
      Get.snackbar("Gallery Error", "Could not save: ${e.type.name}");
    } catch (e) {
      LoggerService.e("Unknown Error saving frame: $e");
     }
  }
   
  double get frameSize => frameWidth * zoom.value;
  double get timelineOffset => currentFrame.value * frameSize;

  List<int> getViisibleFrames(double viewPortWidth) {
    final framesOnScreen = (viewPortWidth / frameSize).ceil();
    const buffer = 10;
    final start = (currentFrame.value - framesOnScreen - buffer).clamp(
      0,
      framePaths.length,
    );
    final end = (currentFrame.value + framesOnScreen + buffer).clamp(
      0,
      framePaths.length,
    );

    return [start, end];
  }

  @override
  void onClose() {
    saveCurrentProject();
    playheadTimer?.cancel();
    videoController.dispose();
    timelineScroll.dispose();
    super.onClose();
  }
}
