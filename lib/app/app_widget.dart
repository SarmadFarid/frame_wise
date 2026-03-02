import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/mvvm/view_model/theme/theme_controller.dart';
import 'package:get/get.dart';

import 'config/app_routes.dart';
import 'theme/app_theme.dart';

class LayerXApp extends StatelessWidget {
  LayerXApp({super.key});

  final controler = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: AppRoutes.splashView,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
