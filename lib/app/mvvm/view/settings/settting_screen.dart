import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/config/app_assets.dart';
import 'package:frame_wise/app/config/app_routes.dart';
import 'package:frame_wise/app/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/cards/profile_cards.dart';
import 'package:frame_wise/app/widgets/custom_button.dart';
import 'package:frame_wise/app/widgets/custom_rich_text.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textstyle = context.themeText;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText('Setting', style: textstyle.titleLarge),

                  Icon(
                    Icons.notifications,
                    color: colors.textDark.withValues(alpha: 0.8),
                    size: 20.sp,
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 15.h),

                      // Profile Section
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          /// 🔹 Profile Image
                          CircleAvatar(
                            radius: 60.r,
                            backgroundImage: AssetImage(AppImages.profileImage),
                          ),

                          ClipOval(
                            child: SizedBox(
                              width: 120.r,
                              height: 120.r,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50.r,
                                  width: double.infinity,
                                  color: Colors.black.withOpacity(0.65),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                        size: 22.sp,
                                      ),
                                      SizedBox(height: 5.h),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      // User Name
                      CustomText('John joseph', style: textstyle.titleMedium),

                      SizedBox(height: 8.h),

                      Divider(height: 20.h, color: colors.surfaceSecondary),

                      // Menu List
                      _buildMenuItem(
                        icon: Icons.person_add_alt_sharp,
                        title: 'Profile',
                        onTap: () {
                          print('ontap profile tab '); 
                          Get.toNamed(AppRoutes.profile); 
                        },
                        context: context,
                      ),

                      _buildMenuItem(
                        icon: Icons.notifications,
                        title: 'Notifications',
                        onTap: () {},
                        context: context,
                      ),

                      _buildMenuItem(
                        icon: Icons.add_card_outlined,
                        title: 'Subscription',
                        onTap: () {
                          Get.toNamed(AppRoutes.subscription);
                        },
                        context: context,
                      ),

                      Divider(height: 10.h, color: colors.surfaceSecondary),

                      _buildMenuItem(
                        icon: Icons.call_outlined,
                        title: 'Call Us',
                        context: context,
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: colors.brandSecondary.withOpacity(
                              0.5,
                            ),
                            builder: (context) {
                              return Dialog(
                                insetPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Container(
                                  width: Get.width * 0.85,
                                  padding: EdgeInsets.all(20.w),
                                  decoration: BoxDecoration(
                                    color: colors.surfacePrimary,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Close Button
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            width: 24.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: colors.brandSecondary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 6.h),

                                      // Phone Icon
                                      Icon(
                                        Icons.wifi_calling_3,
                                        color: colors.textDark,
                                        size: 30.sp,
                                      ),

                                      SizedBox(height: 16.h),

                                      // Title
                                      CustomText(
                                        'Call us to get in touch',
                                        style: textstyle.titleMedium,
                                      ),

                                      SizedBox(height: 10.h),

                                      // Timing
                                      CustomText(
                                        '9:00 AM to 6:00 PM, Monday to Friday',
                                        style: textstyle.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      SizedBox(height: 25.h),

                                      // Phone Number Button
                                      CustomButton(
                                        text: '800-38249953',
                                        onPressed: () {},
                                        bgColor: colors.brandSecondary,
                                        textColor: Colors.white,
                                      ),

                                      SizedBox(height: 20.h),

                                      // Email Text
                                      CustomRichText(
                                        maxLines: 2,
                                        firstText: 'Or email us at : ',
                                        secondText: ' customersupport@xyz.com',
                                        style: textstyle.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                      SizedBox(height: 26.h),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      Divider(height: 10.h, color: colors.surfaceSecondary),
                      SizedBox(height: 30.h),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: colors.surfacePrimary,
                            builder: (_) => ConfirmationBottomSheet(
                              title: 'Logout',
                              description: 'Are you sure you want to log out?',
                              onConfirm: () {
                                Get.back();
                              },
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 25.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                color: context.colors.error,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.power_settings_new_rounded,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            CustomText(
                              'Logout',
                              style: context.themeText.bodyLarge?.copyWith(
                                color: context.colors.textDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    bool? logout,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: (logout ?? false)
                  ? context.colors.error
                  : context.colors.textDark.withValues(alpha: 0.7),
              size: 20.sp,
            ),
            SizedBox(width: 18.w),
            Expanded(
              child: CustomText(
                title,
                style: context.themeText.bodyMedium?.copyWith(
                  color: (logout ?? false)
                      ? context.colors.error
                      : context.colors.textDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ),
            if (!(logout ?? false))
              Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: context.colors.textDark.withValues(alpha: 0.5),
              ),
          ],
        ),
      ),
    );
  }
}
