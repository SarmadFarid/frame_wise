import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/utills/app_routes.dart';
import 'package:frame_wise/app/widgets/cards/profile_cards.dart';
import 'package:get/get.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_button.dart';
import 'package:frame_wise/app/widgets/custom_rich_text.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:frame_wise/app/widgets/custom_text_field.dart';
import 'package:frame_wise/app/mvvm/view_model/auth/auth_ocntroller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),

              /// -------- TITLE ----------
              CustomText(
                'Welcome Back',
                style: context.themeText.displaySmall?.copyWith(
                  color: context.colors.textBrand,
                  fontWeight: FontWeight.w900,
                ),
              ),

              SizedBox(height: 8.h),

              CustomText(
                'Login to continue framing your memories.',
                style: context.themeText.bodyMedium?.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 60.h),

              /// -------- FORM SECTION ----------
              CustomTextField(
                label: "Email",
                hint: "Enter your Email Address",
                prefixIcon: Icons.email,
                // controller: controller.emailController,
              ),

              CustomTextField(
                label: "Password",
                hint: "Enter your Password",
                prefixIcon: Icons.lock,
                isPassword: true,
                // controller: controller.passwordController,
              ),

              /// -------- FORGOT PASSWORD ----------
              Align(
                heightFactor: 0.5.h,
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ProfileCards.showForgotPassDialog(context);
                  },
                  child: CustomText(
                    "Forgot Password?",
                    style: context.themeText.bodyMedium?.copyWith(
                      color: context.colors.textBrand,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50.h),
              // Spacer(),

              /// -------- LOGIN BUTTON ----------
              CustomButton(
                text: "Login ",
                onPressed: () {
                  Get.offAllNamed(AppRoutes.dashBoard);
                },
              ),

              SizedBox(height: 20.h),

              /// -------- FOOTER ----------
              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.signupView),
                  child: const CustomRichText(
                    firstText: 'Don’t have an account? ',
                    secondText: 'Sign Up',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
