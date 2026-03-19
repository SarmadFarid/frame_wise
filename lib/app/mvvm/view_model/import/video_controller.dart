import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frame_wise/app/mvvm/binidngs/frame_analysis_binding.dart';
import 'package:frame_wise/app/mvvm/view/import/frame_analysis_scren.dart';
import 'package:frame_wise/app/mvvm/view_model/project/project_controller.dart';
import 'package:frame_wise/app/services/logger_service.dart';
import 'package:frame_wise/app/services/storage_service.dart';
import 'package:frame_wise/app/services/video_services.dart';
import 'package:get/get.dart';

class ImportVideoController extends GetxController {
  VideoServices videoServices = VideoServices.instance;
  StorageService storageServices = StorageService.instance;
  final projectController = Get.find<ProjectController>();
  var loading = false.obs;
  Future<void> pickVideo() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.video);
      if (result == null) return;
      final videoFile = File(result.files.single.path!);
      loading.value = true;

      // video hash
      final stat = videoFile.statSync();
      final String fileName = videoFile.path.split('/').last;
      final int fileSize = stat.size;
      final videoIdentity = "${fileName}_$fileSize";
      final videoHash = md5.convert(utf8.encode(videoIdentity)).toString();
      LoggerService.i("Generated Video Hash: $videoHash");

      final existingProjectIndex = projectController.projects.indexWhere(
        (p) => p.videoHash == videoHash,
      );

      if (existingProjectIndex != -1) {
        LoggerService.i("Old project found! Resuming existing one.");
        final existingProject =
            projectController.projects[existingProjectIndex];
        final String dirPath = existingProject.thumbnail.substring(
          0,
          existingProject.thumbnail.lastIndexOf('/'),
        );
        Get.to(
          () => FrameAnalysisScreen(),
          binding: FrameAnalysisBinding(),
          arguments: {
            'videoPath': existingProject.videoPath,
            'projectDirPath': dirPath,
            'projectId': existingProject.projectId,
            'thumbnailPath': existingProject.thumbnail,
          },
        );
        return;
      }

      final projectdir = await storageServices.createProjectDirectory(
        videoHash,
      );
      final projectId = projectdir.path.split('/').last;
      final thumbnailPath = await videoServices.generateThumbnail(
        videoFile.path,
        projectdir.path,
      );

      Get.to(
        () => FrameAnalysisScreen(),
        binding: FrameAnalysisBinding(),
        arguments: {
          'videoPath': videoFile.path,
          'projectDirPath': projectdir.path,
          'projectId': projectId,
          'thumbnailPath': thumbnailPath,
        },
      );
    } catch (e) {
      log(e.toString());
    } finally {
      loading.value = false;
    }
  }
}
