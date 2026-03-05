import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/theme/app_fonts_config.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTypography   {
  AppTypography._();
 
  static TextTheme get textTheme => TextTheme(

        /// ===== DISPLAY =====
        displayLarge: TextStyle(
          fontSize: 48.sp,
          fontWeight: FontWeight.w900,
          fontFamily: AppFontsConfig.family,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.w800,
          fontFamily: AppFontsConfig.family,
        ),
        displaySmall: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w700,
          fontFamily: AppFontsConfig.family,
        ),
 
        /// HEADLINE
        headlineLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w600,
          fontFamily: AppFontsConfig.family,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
          fontFamily: AppFontsConfig.family,
        ),
        headlineSmall: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          fontFamily: AppFontsConfig.family,
        ),

        /// TITLE
        titleLarge: GoogleFonts.inter(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFontsConfig.family,
        ),
        titleSmall: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFontsConfig.family,
        ),

        /// BODY
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          fontFamily: AppFontsConfig.family,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: AppFontsConfig.family,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          fontFamily: AppFontsConfig.family,
        ),

        /// LABEL
        labelLarge: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFontsConfig.family,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFontsConfig.family,
        ),
        labelSmall: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFontsConfig.family,
          letterSpacing: 0.5,
        ),
      );
}