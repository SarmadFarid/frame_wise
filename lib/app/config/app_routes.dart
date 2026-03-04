import 'package:frame_wise/app/mvvm/view/bottomNavigation/bottom_navigation.dart';
import 'package:frame_wise/app/mvvm/view/settings/login_security_screen.dart';
import 'package:frame_wise/app/mvvm/view/settings/profile_screen.dart';
import 'package:frame_wise/app/mvvm/view/signup/sign_up_view.dart';
import 'package:frame_wise/app/mvvm/view/subscription/subscription_screen.dart';
import 'package:frame_wise/app/mvvm/view_model/settings/setting_bindings.dart';
import 'package:get/get.dart';

import '../mvvm/view/splash/splash_view.dart';
import '../mvvm/view/login/login_view.dart';
import '../mvvm/view_model/splash/splash_binding.dart';

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
}


abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splashView,
      page: () => const SplashIntroScreen(),
      binding: SplashBinding(), 
      transition: Transition.fadeIn
    ),
    GetPage(
      name: AppRoutes.loginView,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeftWithFade
    ),
     GetPage(
      name: AppRoutes.signupView,
      page: () => const SignUpScreen(),
      transition: Transition.rightToLeftWithFade
    ),
     GetPage(
      name: AppRoutes.dashBoard,
      page: () => const AppBottomNavigation(),
      transition: Transition.fadeIn, 
      bindings: [SettingBindings()]  
    ),
      GetPage(
      name: AppRoutes.subscription,
      page: () => const SubscriptionScreen(),
      transition: Transition.rightToLeftWithFade, 
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () =>   ProfileScreen(),
      transition: Transition.rightToLeftWithFade, 
    ),
    GetPage(
      name: AppRoutes.loginAndSecurityScreen,
      page: () =>   LoginAndSecurityScreen(),
      transition: Transition.rightToLeftWithFade, 
    ),

  ];
}
