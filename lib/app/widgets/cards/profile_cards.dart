import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/theme/theme_extensions.dart';
import 'package:get/get.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onConfirm;
  final String confirmText;
  final bool showBorder;

  const ConfirmationBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.onConfirm,
    this.confirmText = 'confirm',
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.colors.surfacePrimary,  
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
        border: showBorder
            ? Border.all(
                color: context.colors.borderLight,
                width: 1.w,
              )
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

          Divider(
            color: context.colors.borderLight,
          ),

          SizedBox(height: 10.h),

          /// 🔹 DESCRIPTION
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 8.h,
            ),
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
                      color: Colors.white ,
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
}