import 'package:frame_wise/app/app_widget.dart';
import 'package:frame_wise/app/mvvm/view_model/auth/auth_ocntroller.dart';
import 'package:frame_wise/app/mvvm/view_model/theme/theme_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put<AuthController>(AuthController(), permanent: true);
  Get.put<ThemeController>(ThemeController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayerXApp();
  }
}
