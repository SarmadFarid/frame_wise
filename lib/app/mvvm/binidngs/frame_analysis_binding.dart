import 'package:frame_wise/app/mvvm/view_model/import/frame_analysis_controller.dart';
import 'package:frame_wise/app/mvvm/view_model/import/video_controller.dart';
import 'package:get/get.dart';

class ImportVideoBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => ImportVideoController(), fenix:  true); 
  }
}

class FrameAnalysisBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut(() => FrameAnalysisController(), fenix:  true); 
  }
}
