import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:frame_wise/app/mvvm/binidngs/frame_analysis_binding.dart';
import 'package:frame_wise/app/mvvm/view/import/frame_analysis_scren.dart';
import 'package:frame_wise/app/services/storage_service.dart';
import 'package:frame_wise/app/services/video_services.dart';
import 'package:get/get.dart';



class ImportVideoController extends GetxController {
  var loading = false.obs;
  Future<void> pickVideo() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.video);
      if (result == null) return;
      final videoPath = result.files.single.path!;
      loading.value = true;
      final projectdir = await StorageService.createProjectDirectory();
      final projectId = projectdir.path.split('/').last ;
      final thumbnailPath = '${projectdir.path}/thumb.png' ;
      await VideoServices.generateThumbnail(videoPath, thumbnailPath);

      Get.to(
        () => FrameAnalysisScreen(),
        binding: FrameAnalysisBinding() ,
        arguments:{
        'videoPath': videoPath,
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
