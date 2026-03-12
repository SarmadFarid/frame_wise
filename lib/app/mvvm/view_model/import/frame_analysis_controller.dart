import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frame_wise/app/mvvm/model/video_models.dart';
import 'package:frame_wise/app/services/frame_extractor_service.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FrameAnalysisController extends GetxController {
  late VideoPlayerController videoController;
  late ProjectJsonModel currentProject;
  RxList<FrameModel> frames = <FrameModel>[].obs;
  RxBool loading = true.obs;
  RxBool isPlaying = false.obs;
  RxInt currentFrame = 0.obs;
  RxDouble zoom = 1.0.obs;
  List<FrameModel> removedFrames = [];
  final ScrollController timelineScroll = ScrollController();
  final double frameWidth = 80;
  Timer? playheadTimer;

  late String videoPath;
  late String projectDirPath;
  late String projectId;
  late String thumbnailPath;

  @override
  void onInit() async {
    final args = Get.arguments as Map<String, dynamic>;

    log('arguments : $args');
    videoPath = args['videoPath'];
    projectDirPath = args['projectDirPath'];
    projectId = args['projectId'];
    thumbnailPath = args['thumbnailPath'];

    await loadFrames();
    super.onInit();
  }

  Future<void> loadFrames() async {
    final result = await FrameExtractorService.extractFrames(
      videoPath: videoPath,
      projectDirPath: projectDirPath,
      projectId: projectId,
      thumbnailPath: thumbnailPath,
    );

    if (result.isNotEmpty) {
      currentProject = result['projectData'];
      List<String> framePaths = result['frames'];

      frames.assignAll(
        framePaths.asMap().entries.map(
          (e) => FrameModel(
            index: e.key,
            path: e.value,
            timestamp: e.key / 2,
            issueDetected: false,
          ),
        ),
      );

      videoController = VideoPlayerController.file(
        File(currentProject.proxyPath),
      );
      await videoController.initialize();

      loading.value = false;

      startTracking();
    }
  }

  void startTracking() {
    final fps = 2;
    playheadTimer?.cancel();
    playheadTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!videoController.value.isInitialized) return;
      final ms = videoController.value.position.inMilliseconds;

      final pos = (ms / 1000) * fps;
      final frameIndex = pos.floor().clamp(0, frames.length - 1);
      if (frameIndex != currentFrame.value) {
        currentFrame.value = frameIndex;
        autoScroll(frameIndex);
      }
      isPlaying.value = videoController.value.isPlaying;
    });
  }

  void autoScroll(int frame) {
    currentFrame.value = frame;
    final offset = frame * frameWidth * zoom.value;
    timelineScroll.animateTo(
      offset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void selectFrame(int index) {
    if (index < 0 || index >= frames.length) return;
    currentFrame.value = index;
    videoController.seekTo(Duration(seconds: index));

    autoScroll(index);
  }

  String getVideoDuration() {
    final duration = videoController.value.duration;
    final totalSeconds = duration.inSeconds;
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    String durationStr = hours > 0
        ? '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
        : '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return durationStr;
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
    if (index < 0 || index >= frames.length) return;
    final frame = frames[index];
    removedFrames.add(frame);
    frames.removeAt(index);
  }

  void undoDelete() {
    if (removedFrames.isEmpty) return;
    frames.add(removedFrames.removeLast());
  }

  @override
  void onClose() {
    playheadTimer?.cancel();

    videoController.dispose();

    timelineScroll.dispose();

    super.onClose();
  }
}

/* {
save metadata example for project and latter exporting
  "id": "project_01",
  "title": "My Video",
  "videoPath": "/gallery/video.mp4",
  "framesFolder": "/app/frames_abc/",
  "thumbnail": "/app/thumbs/project_01.png",
  "fps": 2,
  "deletedFrames": [3,5],
  "createdAt": "2026-03-11"
} 

Structure for saving projects 
app_documents/
   projects/
      project_1/
         project.json
         thumbnail.jpg
         frames/

         
*/
