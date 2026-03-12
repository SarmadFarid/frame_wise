import 'package:frame_wise/app/mvvm/binidngs/frame_analysis_binding.dart';
import 'package:frame_wise/app/mvvm/view/bottomNavigation/bottom_navigation.dart';
import 'package:frame_wise/app/mvvm/view/import/import_video_screen.dart';
import 'package:frame_wise/app/mvvm/view/settings/login_security_screen.dart';
import 'package:frame_wise/app/mvvm/view/settings/profile_screen.dart';
import 'package:frame_wise/app/mvvm/view/auth/sign_up_view.dart';
import 'package:frame_wise/app/mvvm/view/settings/subscription_screen.dart';
import 'package:frame_wise/app/mvvm/binidngs/project_binding.dart';
import 'package:frame_wise/app/mvvm/binidngs/setting_bindings.dart';
import 'package:get/get.dart';

import '../../mvvm/view/splash/splash_view.dart';
import '../../mvvm/view/auth/login_view.dart';
import '../../mvvm/binidngs/splash_binding.dart';

/// Defines navigation routes for the LayerX app.
abstract class AppRoutes {
  AppRoutes._();

  static const splashView = '/';
  static const loginView = '/login';
  static const signupView = '/signup';
  static const dashBoard = '/dashboard';
  static const subscription = '/subscription';
  static const profile = '/profile';
  static const loginAndSecurityScreen = '/LoginAndSecurityScreen';
  static const importvideoScren = '/importvideoscreen';
}

abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splashView,
      page: () => const SplashIntroScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.loginView,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.signupView,
      page: () => const SignUpScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.dashBoard,
      page: () => const AppBottomNavigation(),
      transition: Transition.fadeIn,
      bindings: [SettingBindings(), ProjectBinding(), SettingBindings(), FrameAnalysisBinding()],
    ),
    GetPage(
      name: AppRoutes.subscription,
      page: () => const SubscriptionScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.loginAndSecurityScreen,
      page: () => LoginAndSecurityScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
     GetPage(
      name: AppRoutes.importvideoScren,
      page: () => ImportVideoScreen(),
      transition: Transition.rightToLeftWithFade,
      binding: FrameAnalysisBinding()
    ),
  ];
}
