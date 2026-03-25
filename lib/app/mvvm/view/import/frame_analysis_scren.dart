import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/mvvm/view_model/import/frame_analysis_controller.dart';
import 'package:frame_wise/app/widgets/custom_frame_timeline.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
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
          return Center(
            child: Container( 
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              padding: EdgeInsets.all(25.w),
              decoration: BoxDecoration(
                color: context.colors.surfaceCard,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 1. Sleek Loader
                  SpinKitThreeBounce(
                    color: context.colors.brandPrimary,
                    size: 35.w,
                  ),
                  SizedBox(height: 25.h),

                  // 2. Dynamic Message
                  CustomText(
                    controller.progressMessage.value,
                    maxLines: 1, 
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: LinearProgressIndicator(
                            value: controller.progress.value,
                            minHeight: 8.h,
                            backgroundColor: context.colors.surfaceInput,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.colors.brandPrimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      CustomText(
                        "${(controller.progress.value * 100).toStringAsFixed(0)}%",
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: context.colors.brandPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
              mainAxisAlignment: MainAxisAlignment.center ,
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
