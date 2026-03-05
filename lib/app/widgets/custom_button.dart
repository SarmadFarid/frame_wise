import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? bgColor; 
  final Color? textColor; 
  final double? width; 

  const CustomButton({super.key, required this.text, required this.onPressed, this.bgColor, this.textColor, this.width});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.themeText;

    return SizedBox(
      width: width ?? double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? colors.brandPrimary,
          foregroundColor: colors.textDark,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          
        ),
        child: CustomText(
          text,
          style: textTheme.labelLarge?.copyWith(
            color : textColor ?? colors.textDark,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
