import 'package:flutter/material.dart';
import 'package:frame_wise/app/mvvm/view_model/import/video_controller.dart';
import 'package:get/get.dart';

class ImportVideoScreen extends StatelessWidget {
  ImportVideoScreen({super.key});

  final ImportVideoController controller = Get.find<ImportVideoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Import Video")),

      body: Obx(() {
        if (controller.loading.value) {
          return Center(child: Text('Generating Thumbnail...'));
        }

        return Center(
          child: ElevatedButton(
            onPressed: controller.pickVideo,
            child: const Text("Select Video"),
          ),
        );
      }),
    );
  }
}
