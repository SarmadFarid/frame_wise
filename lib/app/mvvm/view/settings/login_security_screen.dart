import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/theme/app_fonts_config.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_button.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';

class LoginAndSecurityScreen extends StatelessWidget {
  const LoginAndSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              GestureDetector(
                onTap: () => Get.back(),
                child: SizedBox(
                  height: 25.h,
                  width: 25.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.bgInverse,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: context.colors.textInverse,
                        size: 15.sp,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              CustomText(
                'Security',
                style: context.themeText.titleLarge?.copyWith(
                  color: context.colors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 5.h),

              CustomText(
                'Sign out from all devices',
                style: context.themeText.bodyLarge?.copyWith(
                  color: context.colors.textDark.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.inter,
                ),
              ),

              SizedBox(height: 5.h),

              CustomText(
                "Logged in on a shared device but forgot to sign out? End all sessions by signing out from all devices ",
                style: context.themeText.bodyMedium?.copyWith(
                  color: context.colors.textGrey,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.inter,
                ),
              ),

              SizedBox(height: 15.h),
              CustomButton(
                bgColor: context.colors.brandSecondary,
                textColor: Colors.white,
                text: 'Sign out from all devices',
                onPressed: () {},
              ),

              SizedBox(height: 40.h),

              CustomText(
                'Delete your account',
                style: context.themeText.titleLarge?.copyWith(
                  color: context.colors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 5.h),

              CustomText(
                "By deleting your account, you'll no longer be able to access any of your designs or log in to FrameWise. Your FrameWise account was created at 11:26 AM, Apr 30, 2023.",
                style: context.themeText.bodyMedium?.copyWith(
                  color: context.colors.textGrey,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.inter,
                ),
              ),

              SizedBox(height: 15.h),
              CustomButton(
                bgColor: context.colors.brandSecondary,
                textColor: Colors.white,
                text: 'Delete Account',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
