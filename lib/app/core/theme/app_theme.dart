import 'package:flutter/material.dart';
import 'package:frame_wise/app/core/theme/app_text_theme.dart';
import 'app_colors.dart';
import 'app_theme_extension.dart';

class AppTheme {
  AppTheme._();
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: AppTypography.textTheme.apply(
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.brandBlue,
      onPrimary: AppColors.white,
      secondary: AppColors.brandDarkBlue,
      onSecondary: AppColors.white,
      error: AppColors.error,
      onError: AppColors.white,
      background: AppColors.bgLight,
      onBackground: AppColors.textDark,
      surface: AppColors.white,
      onSurface: AppColors.textDark,
    ),

    scaffoldBackgroundColor: AppColors.bgLight,

    extensions: const [

      AppThemeColors(
        brandPrimary: AppColors.brandBlue,
        brandSecondary: AppColors.brandDarkBlue,

        bgPrimary: AppColors.bgLight,
        bgSecondary: AppColors.bgGrey,
        bgTertiary: AppColors.white,
        bgInverse: AppColors.bgDark,
        bgBrand: AppColors.brandBlue,

        surfacePrimary: AppColors.white,
        surfaceSecondary: AppColors.bgGrey,
        surfaceElevated: AppColors.white,
        surfaceCard: AppColors.white,
        surfaceModal: AppColors.white,
        surfaceInput: AppColors.bgGrey,

        borderLight: AppColors.borderColor,
        borderDefault: AppColors.borderGrey,
        borderStrong: AppColors.grey,
        borderBrand: AppColors.brandBlue,

        textDark: AppColors.textDark,
        textGrey: AppColors.textGrey,
        textLightGrey: AppColors.greyLight,
        textDisabled: AppColors.greyMedium,
        textBrand: AppColors.brandDarkBlue,
        textPrimary: AppColors.brandBlue,
        textInverse: AppColors.white,

        success: AppColors.success,
        error: AppColors.error,
        warning: AppColors.warning,
        info: AppColors.info,

        successContainer: Color(0xffECFDF5),
        errorContainer: Color(0xffFEF2F2),
        warningContainer: Color(0xffFFFBEB),
        infoContainer: Color(0xffEFF6FF),

        timelineHighlight: AppColors.brandBlue,
        selectedFrame: AppColors.brandDarkBlue,
        aiSuggestion: AppColors.brandBlue,
      ),
    ],
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: AppTypography.textTheme.apply(
    bodyColor: AppColors.textLight,
    displayColor: AppColors.textLight,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.brandBlue,
      onPrimary: AppColors.black,
      secondary: AppColors.brandDarkBlue,
      onSecondary: AppColors.white,
      error: AppColors.error,
      onError: AppColors.white,
      background: AppColors.bgDark,
      onBackground: AppColors.white,
      surface: AppColors.greyDark,
      onSurface: AppColors.white,
    ),

    scaffoldBackgroundColor: AppColors.bgDark,

    extensions: const [
      AppThemeColors(
        brandPrimary: AppColors.brandBlue,
        brandSecondary: AppColors.brandDarkBlue,

        bgPrimary: AppColors.bgDark,
        bgSecondary: AppColors.greyDark,
        bgTertiary: Color(0xff2A2A2A),
        bgInverse: AppColors.white,
        bgBrand: AppColors.brandBlue,

        surfacePrimary: AppColors.bgDark,
        surfaceSecondary: Color(0xff2A2A2A),
        surfaceElevated: Color(0xff323232),
        surfaceCard: AppColors.greyDark,
        surfaceModal: AppColors.greyDark,
        surfaceInput: Color(0xff2A2A2A),

        borderLight: Color(0xff2A2A2A),
        borderDefault: Color(0xff3A3A3A),
        borderStrong: AppColors.grey,
        borderBrand: AppColors.brandBlue,

        textDark: AppColors.white,
        textGrey: AppColors.grey,
        textLightGrey: AppColors.greyMedium,
        textDisabled: Color(0xff555555),
        textBrand: AppColors.textLight,
        textPrimary: AppColors.brandBlue,
        textInverse: AppColors.black,

        success: AppColors.success,
        error: AppColors.error,
        warning: AppColors.warning,
        info: AppColors.info,

        successContainer: Color(0xff052E1B),
        errorContainer: Color(0xff2B0B0E),
        warningContainer: Color(0xff2E1F05),
        infoContainer: Color(0xff0C1E3A),

        timelineHighlight: AppColors.brandBlue,
        selectedFrame: AppColors.brandDarkBlue,
        aiSuggestion: AppColors.brandBlue,
      ),
    ],
  );
}
