import 'package:frame_wise/app/mvvm/view_model/settings/profile_controller.dart';
import 'package:get/get.dart';

class SettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController() , fenix: true ); 
  }
}