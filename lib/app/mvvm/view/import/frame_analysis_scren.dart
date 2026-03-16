import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/mvvm/view_model/import/frame_analysis_controller.dart';
import 'package:frame_wise/app/widgets/custom_frame_timeline.dart';
import 'package:frame_wise/app/widgets/issue_pannel_widget.dart';
import 'package:frame_wise/app/widgets/video_preview_widget.dart';
import 'package:get/get.dart';

class FrameAnalysisScreen extends StatelessWidget {
  const FrameAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Frame Analysis")),

      body: Obx(() {
        if (controller.loading.value) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.progressMessage.value),
              SizedBox(height: 20),
              LinearProgressIndicator(value: controller.progress.value),
              SizedBox(height: 10),
              Text("${(controller.progress.value * 100).toStringAsFixed(0)} %"),
            ],
          );
        }

        return Column(
          children: [
            /// VIDEO PREVIEW
            ///
            SizedBox(height: 220.h, child: VideoPreviewWidget()),

            /// VIDEO CONTROLS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () =>
                      controller.selectFrame(controller.currentFrame.value - 1),
                ),

                Obx(
                  () => IconButton(
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    onPressed: () {
                      controller.isPlaying.value
                          ? controller.pause()
                          : controller.play();
                    },
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: () =>
                      controller.selectFrame(controller.currentFrame.value + 1),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.play_circle_fill),
                SizedBox(width: 5.w),
                Obx(
                  () => Text(
                    controller.isVideoInitialized.value
                        ? controller.getVideoDuration()
                        : "00:00",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// TIMELINE TOOLBAR
            const TimelineToolbarWidget(),

            /// TIMELINE RULER
            SizedBox(
              height: 25,
              child: TimelineRulerWidget(
                frameCount: controller.framePaths.length,
              ),
            ),

            /// FRAME TIMELINE
            SizedBox(height: 80.h, child: TimelineFramesWidget()),

            /// ISSUE PANEL
            Expanded(child: IssuePanelWidget()),
          ],
        );
      }),
    );
  }
}
