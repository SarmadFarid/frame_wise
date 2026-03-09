import 'package:frame_wise/app/mvvm/view_model/project/project_controller.dart';
import 'package:get/get.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectController>(() => ProjectController(), fenix: true);
  }
}
