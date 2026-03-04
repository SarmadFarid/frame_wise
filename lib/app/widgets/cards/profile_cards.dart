import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/mvvm/view_model/settings/notification_controller.dart';
import 'package:frame_wise/app/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_button.dart';
import 'package:frame_wise/app/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';

class ProfileCards {
  static Widget confirmationBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onConfirm,
    String confirmText = 'confirm',
    bool showBorder = false,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.colors.surfacePrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        border: showBorder
            ? Border.all(color: context.colors.borderLight, width: 1.w)
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  title,
                  style: context.themeText.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.colors.textBrand,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 26.w,
                  height: 26.h,
                  decoration: BoxDecoration(
                    color: context.colors.textBrand,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: context.colors.textInverse,
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Divider(color: context.colors.borderLight),

          SizedBox(height: 10.h),

          /// 🔹 DESCRIPTION
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
            child: CustomText(
              description,
              style: context.themeText.bodyLarge?.copyWith(
                color: context.colors.textGrey,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// 🔹 ACTIONS
          Row(
            children: [
              /// CANCEL BUTTON
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 44.h),
                    side: BorderSide(
                      color: context.colors.borderLight,
                      width: 1.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: CustomText(
                    'Cancel',
                    style: context.themeText.labelLarge?.copyWith(
                      color: context.colors.textBrand,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              /// CONFIRM BUTTON
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: context.colors.brandSecondary,
                    minimumSize: Size(double.infinity, 44.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: CustomText(
                    confirmText.tr,
                    style: context.themeText.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  static void showNotificationSettingsDialog(
    BuildContext context, {
    required NotificationController controller,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          width: Get.width * 0.85,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: context.colors.surfacePrimary,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [BoxShadow(color: Colors.white, blurRadius: 6.r)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                'Notifications',
                color: context.colors.textBrand,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
              // Row 1: Pop up notification
              SizedBox(height: 20.h),
              _buildNotificationRow(
                context,
                title: "Pop up notification on desktop",
                value: controller.isPopupOn,
              ),
              SizedBox(height: 12.h),

              // Row 2: New update notification
              _buildNotificationRow(
                context,
                title: "Turn on new update notification",
                value: controller.isUpdateOn,
              ),
              SizedBox(height: 12.h),

              // Row 3: Security notification
              _buildNotificationRow(
                context,
                title: "Turn on security notification",
                value: controller.isSecurityOn,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  static void showChangePassDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),

        elevation: 2,
        child: Container(
          width: Get.width * 0.85,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: context.colors.surfacePrimary,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [BoxShadow(color: Colors.white, blurRadius: 6.r)],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                textAlign: TextAlign.center,
                'Change Your Password',
                style: context.themeText.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colors.textBrand,
                ),
              ),

              SizedBox(height: 30.h),
              CustomTextField(
                label: 'Old Password',
                hint: 'Enter your old password',
                isPassword: true,
              ),

              Align(
                heightFactor: 0,
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: CustomText(
                    'Forgot Password',
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              CustomTextField(
                label: 'New Password',
                hint: 'Enter your new password',
                isPassword: true,
              ),

              CustomTextField(
                label: 'Confirm Password',
                hint: 'Re-enter your new password',
                isPassword: true,
              ),

              SizedBox(height: 15.h),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Save',
                      onPressed: () {},
                      bgColor: context.colors.textBrand,
                      textColor: context.colors.textInverse,
                    ),
                  ),

                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: CustomText(
                        'Cancel',
                        color: context.colors.textBrand,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNotificationRow(
  BuildContext context, {
  required String title,
  required RxBool value,
}) {
  return Obx(
    () => Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.colors.surfaceInput,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              title,
              style: context.themeText.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colors.textDark.withValues(alpha: 0.7),
              ),
            ),
          ),

          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value.value,
              onChanged: (val) => value.value = val,
              activeTrackColor: context.colors.textBrand,
              activeThumbColor: context.colors.textInverse,
            ),
          ),
        ],
      ),
    ),
  );
}
