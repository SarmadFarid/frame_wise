import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/utills/app_routes.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_rich_text.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:frame_wise/app/mvvm/view_model/auth/auth_ocntroller.dart';
import 'package:frame_wise/app/widgets/custom_button.dart';
import 'package:frame_wise/app/widgets/custom_text_field.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeController = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),

              CustomText(
                'Sign up',
                style: context.themeText.displayMedium?.copyWith(
                  color: context.colors.textBrand,
                  fontWeight: FontWeight.w900,
                ),
              ),

              SizedBox(height: 8.h),

              CustomText(
                'Create account to start framing your memories.',
                textAlign: TextAlign.start,
                style: context.themeText.bodyMedium?.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 45.h),

              // --- FORM SECTION ---
              const CustomTextField(
                label: "Email",
                hint: "Enter your Email Address",
                prefixIcon: Icons.email,
              ),

              const CustomTextField(
                label: "Username",
                hint: "Enter your User Name",
                prefixIcon: Icons.person,
              ),

              const CustomTextField(
                label: "Password",
                hint: "Enter your Password",
                prefixIcon: Icons.lock,
                isPassword: true,
              ),

              const CustomTextField(
                label: "Confirm Password",
                hint: "Confirm your Password",
                prefixIcon: Icons.lock,
                isPassword: true,
              ),

              SizedBox(height: 50.h),

              // --- BUTTON SECTION ---
              CustomButton(text: "Register ", onPressed: () {}),

              SizedBox(height: 20.h),

              // --- FOOTER SECTION ---
              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.loginView),
                  child: CustomRichText(
                    firstText: 'Already have an account? ',
                    secondText: 'Login',
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
