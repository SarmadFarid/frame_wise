import 'package:flutter/material.dart';
import 'package:frame_wise/app/mvvm/view_model/import/frame_analysis_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewWidget extends StatelessWidget {
  const VideoPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();
    return Obx(() {
      if (!controller.isVideoInitialized.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return AspectRatio(
        aspectRatio: controller.videoController.value.aspectRatio,
        child: VideoPlayer(controller.videoController),
      );
    });
  }
}
