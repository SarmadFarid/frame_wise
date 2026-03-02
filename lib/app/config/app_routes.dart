import 'package:frame_wise/app/mvvm/view/bottomNavigation/dashboard_screen.dart';
import 'package:frame_wise/app/mvvm/view/signup/sign_up_view.dart';
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
      page: () => const DashboardScreen(),
      transition: Transition.fadeIn, 
      
    ),

  ];
}
