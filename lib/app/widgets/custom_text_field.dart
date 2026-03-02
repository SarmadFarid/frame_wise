import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final textTheme = context.themeText ; 
  final colors = context.colors ; 
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Section
        Row(
          children: [
            Icon(
              prefixIcon, 
              size: 18.sp, 
              color: colors.textDark ,
            ),
            SizedBox(width: 8.w),
            CustomText(
              label, 
              style: textTheme.labelLarge ,
            ) , 
             
          ],
        ),
        SizedBox(height: 8.h),
        
        // Input Field
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          style: textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:  textTheme.bodySmall ,
            filled: true,
            fillColor: colors.surfaceInput, 
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            
            // Default Border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            
            // Focused Border (Sky Blue color jab user click kare)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: colors.borderLight , 
                width: 1.5.w
              ),
            ),
            
            // Jab field error de
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.error , width: 1.w),
            ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}