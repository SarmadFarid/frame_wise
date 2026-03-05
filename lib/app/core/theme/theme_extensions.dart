import 'package:flutter/material.dart';
import 'package:frame_wise/app/core/theme/app_fonts_config.dart';
import 'app_theme_extension.dart';

extension ThemeGetter on BuildContext {
  TextTheme get themeText => Theme.of(this).textTheme ; 
  AppThemeColors get colors =>
      Theme.of(this).extension<AppThemeColors>()!;

    String get fontFamily => AppFontsConfig.family ;   
}