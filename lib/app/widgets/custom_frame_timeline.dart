import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/mvvm/view_model/import/frame_analysis_controller.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';

class TimelineToolbarWidget extends StatelessWidget {
  const TimelineToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            controller.deleteFrame(controller.currentFrame.value);
          },
        ),
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: controller.undoDelete,
        ),
        // const Spacer(),
        Obx(() => Text("Frame ${controller.currentFrame.value}")),
        const Spacer(),
        SizedBox(
          width: 120.w,
          child: Obx(
            () => Slider(
              min: 0.5,
              max: 3,
              value: controller.zoom.value,
              onChanged: (v) {
                controller.zoom.value = v;
              },
            ),
          ),
        ),
      ],
    );
  }
}

class TimelineRulerWidget extends StatelessWidget {
  final int frameCount;
  final double fps;

  const TimelineRulerWidget({
    super.key,
    required this.frameCount,
    this.fps = 2,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();
    return SizedBox(
      height: 25.h,
      child: Obx(() {
        final width = controller.frameWidth * controller.zoom.value;

        return ListView.builder(
          controller: controller.timelineScroll,
          scrollDirection: Axis.horizontal,
          itemCount: (frameCount / fps).ceil(),
          itemBuilder: (context, index) {
            final showLabel = index % fps == 0;

            if (!showLabel) {
              return SizedBox(width: width);
            }
            final seconds = (index / fps).floor();
            final minutes = (seconds ~/ 60);
            final sec = (seconds % 60);

            return SizedBox(
              width: controller.frameWidth * controller.zoom.value,

              child: CustomText(
                "${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}",
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      }),
    );
  }
}

class TimelineFramesWidget extends StatelessWidget {
  const TimelineFramesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          final range = controller.getViisibleFrames(constraints.maxWidth);
          final start = range[0];
          final end = range[1];
          final visibleFrames = controller.framePaths.sublist(start, end);

          return Stack(
            children: [
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  final deltaFrames = details.delta.dx / controller.frameSize;
                  final newFrame = controller.currentFrame.value - deltaFrames;
                  controller.selectFrame(newFrame.round());
                },
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: OverflowBox(
                    maxWidth: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Transform.translate(
                      offset: Offset(
                        -(controller.timelineOffset - constraints.maxWidth / 2),
                        0,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Row(
                          children: [
                            SizedBox(width: start * controller.frameSize),
                            ...List.generate(visibleFrames.length, (i) {
                              final index = start + i;
                              return Obx(() {
                                final selected =
                                    controller.currentFrame.value == index;
                                final deleted = controller.deletedFrames
                                    .contains(index);
                                final width =
                                    controller.frameWidth *
                                    controller.zoom.value;
                                return FrameTileWidget(
                                  path: visibleFrames[i],
                                  index: index,
                                  selected: selected,
                                  width: width,
                                  deleted: deleted,
                                );
                              });
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const Center(child: TimelinePlayheadWidget()),
            ],
          );
        });
      },
    );
  }
}

class FrameTileWidget extends StatelessWidget {
  final String path;
  final int index;
  final bool selected;
  final bool deleted;
  final double width;

  const FrameTileWidget({
    super.key,
    required this.path,
    required this.index,
    requi,
    required this.selected,
    required this.deleted,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();

    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          controller.selectFrame(index);
        },
        child: Opacity(
          opacity: deleted ? 0.3 : 1,
          child: SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selected
                              ? context.colors.brandPrimary
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: context.colors.brandPrimary
                                      .withOpacity(0.6),
                                  blurRadius: 6,
                                ),
                              ]
                            : [],

                        
                      ),
                      child: Image.file(
                        File(path),
                        width: controller.frameSize,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        cacheWidth: 100,
                        gaplessPlayback: true,
                        filterQuality: FilterQuality.low,
                        errorBuilder: (context, error, stackTrace) {
                          return DecoratedBox(
                            decoration: BoxDecoration(color: Colors.black),
                            child: Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Text("F$index", style: context.themeText.bodyMedium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimelinePlayheadWidget extends StatelessWidget {
  const TimelinePlayheadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2.w,
      height: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.colors.brandPrimary),
      ),
    );
  }
}
