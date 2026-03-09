import 'package:flutter/material.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  // ===== BRAND (FIXED BOTH THEMES) =====
  final Color brandPrimary;
  final Color brandSecondary;

  // ===== BACKGROUND SYSTEM =====
  final Color bgPrimary;
  final Color bgSecondary;
  final Color bgTertiary;
  final Color bgInverse;
  final Color bgBrand;

  // ===== SURFACE SYSTEM =====
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceElevated;
  final Color surfaceCard;
  final Color surfaceModal;
  final Color surfaceInput;

  // ===== BORDER SYSTEM =====
  final Color borderLight;
  final Color borderDefault;
  final Color borderStrong;
  final Color borderBrand;

  // ===== TEXT SYSTEM =====
  final Color textDark;
  final Color textGrey;
  final Color textLightGrey;
  final Color textDisabled;
  final Color textPrimary;
  final Color textBrand;
  final Color textInverse;

  // ===== STATUS =====
  final Color success;
  final Color error;
  final Color warning;
  final Color info;

  // ===== STATUS CONTAINER =====
  final Color successContainer;
  final Color errorContainer;
  final Color warningContainer;
  final Color infoContainer;

  // ===== SPECIAL FRAMEWISE =====
  final Color timelineHighlight;
  final Color selectedFrame;
  final Color aiSuggestion;

  const AppThemeColors({
    required this.brandPrimary,
    required this.brandSecondary,
    required this.bgPrimary,
    required this.bgSecondary,
    required this.bgTertiary,
    required this.bgInverse,
    required this.bgBrand,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.surfaceElevated,
    required this.surfaceCard,
    required this.surfaceModal,
    required this.surfaceInput,
    required this.borderLight,
    required this.borderDefault,
    required this.borderStrong,
    required this.borderBrand,
    required this.textDark,
    required this.textGrey,
    required this.textLightGrey,
    required this.textDisabled,
    required this.textBrand,
    required this.textPrimary,
    required this.textInverse,
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
    required this.successContainer,
    required this.errorContainer,
    required this.warningContainer,
    required this.infoContainer,
    required this.timelineHighlight,
    required this.selectedFrame,
    required this.aiSuggestion,
  });

  @override
  AppThemeColors copyWith({Color? bgPrimary}) {
    return this;
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return this;
  }
}
