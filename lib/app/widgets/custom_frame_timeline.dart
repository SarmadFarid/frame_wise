import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frame_wise/app/mvvm/model/video_models.dart';
import 'package:frame_wise/app/mvvm/view_model/import/frame_analysis_controller.dart';
import 'package:get/get.dart';

class TimelineToolbarWidget extends StatelessWidget {
  const TimelineToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();

    return Row(
      children: [
        IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        IconButton(icon: const Icon(Icons.copy), onPressed: () {}),
        // const Spacer(),
        Obx(() => Text("Frame ${controller.currentFrame.value}")),
        const Spacer(),
        SizedBox(
          width: 120,
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
  final double fps ;

  const TimelineRulerWidget({super.key, required this.frameCount, this.fps = 2});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();
    return SizedBox(
      height: 25,
      child: ListView.builder(
        controller: controller.timelineScroll,
        scrollDirection: Axis.horizontal,
        itemCount: frameCount,
        itemBuilder: (context, index) {
          return Obx(() {
            final seconds = (index / fps).floor();
            final minutes = (seconds ~/ 60);
            final sec = (seconds % 60);

            return Container(
              width: controller.frameWidth * controller.zoom.value,
              alignment: Alignment.center,
              child: Text(
                "${minutes.toString().padLeft(2,'0')}:${sec.toString().padLeft(2,'0')}",
                style: const TextStyle(fontSize: 10),
              ),
            );
          });
        },
      ),
    );
  }
}

class TimelineFramesWidget extends StatelessWidget {
  final List<FrameModel> frames;

  const TimelineFramesWidget({super.key, required this.frames});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();

    return Stack(
      children: [
        ListView.builder(
          controller: controller.timelineScroll,
          scrollDirection: Axis.horizontal,
          itemCount: frames.length,
          itemBuilder: (context, index) {
            final frame = frames[index];
            return FrameTileWidget(frame: frame);
          },
        ),

        Positioned.fill(child: TimelinePlayheadWidget()),
      ],
    );
  }
}

class FrameTileWidget extends StatelessWidget {
  final FrameModel frame;

  const FrameTileWidget({super.key, required this.frame});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();
    return Obx(() {
      final selected = controller.currentFrame.value == frame.index;
      return GestureDetector(
        onTap: () {
          controller.selectFrame(frame.index);
        },
        child: Container(
          width: controller.frameWidth * controller.zoom.value,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 50,

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selected ? Colors.blue : Colors.transparent,
                        width: 2,
                      ),

                      image: DecorationImage(
                        image: FileImage(File(frame.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  if (frame.issueDetected)
                    const Positioned(
                      right: 3,
                      top: 3,

                      child: Icon(
                        Icons.warning,
                        size: 14,
                        color: Colors.orange,
                      ),
                    ),
                ],
              ),

              Text("F${frame.index}", style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      );
    });
  }
}

class TimelinePlayheadWidget extends StatelessWidget {
  const TimelinePlayheadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FrameAnalysisController>();

    return Obx(() {
      // Clamp currentFrame to valid range
      final frameIndex = controller.currentFrame.value.clamp(0, controller.frames.length - 1);
      final position = frameIndex * controller.frameWidth * controller.zoom.value;

      return Positioned(
        left: position,
        top: 0,
        bottom: 0,
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            final frame = ((position + details.delta.dx) /
                    (controller.frameWidth * controller.zoom.value))
                .clamp(0, controller.frames.length - 1)
                .floor();

            controller.selectFrame(frame);
          },
          child: Container(width: 2, color: Colors.blue),
        ),
      );
    });
  }
}