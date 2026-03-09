import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final bool isPassword;
  final FocusNode? focusNode;
  final Widget? suffixWidget;
  final bool readOnly;
  final int? maxLines;
  final String? initialValue;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.focusNode,
    this.suffixWidget,
    this.isPassword = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.controller,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.themeText;
    final colors = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Section
        Row(
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, size: 18.sp, color: colors.textDark),
              SizedBox(width: 8.w),
            ],
            CustomText(label, style: textTheme.labelLarge),
          ],
        ),
        SizedBox(height: 8.h),

        // Input Field
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          initialValue: initialValue,
          readOnly: readOnly,
          focusNode: focusNode,
          maxLines: isPassword ? 1 : maxLines,
          style: textTheme.bodyMedium?.copyWith(
            color: readOnly ? colors.textGrey : colors.textDark,
            fontWeight: readOnly ? FontWeight.normal : FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textTheme.bodySmall?.copyWith(
              color: colors.textDark.withValues(alpha: 0.7),
            ),
            filled: true,
            fillColor: colors.surfaceInput,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),

            suffixIcon: suffixWidget,
            suffixIconConstraints: BoxConstraints(minHeight: 0, minWidth: 0),
            // Default Border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),

            // Focused Border
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.borderLight, width: 1.5.w),
            ),

            // Error Border
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.error, width: 1.w),
            ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}
