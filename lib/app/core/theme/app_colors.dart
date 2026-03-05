import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  // ===== BRAND (NEVER CHANGE) =====
  static const Color brandBlue = Color(0xff8cd9fe);
  static const Color brandDarkBlue = Color(0xff343c6a);

  // ===== ORIGINAL BACKGROUNDS (PRESERVED) =====
  static const Color bgLight = Color(0xffF8FAFC);
  static const Color bgGrey = Color(0xffEDF2F6);
  static const Color bgDark = Color(0xff1c1c1c);

  // ===== NEUTRAL SCALE =====
  static const Color greyLight = Color(0xffEDF2F6);
  static const Color greyMedium = Color(0xffD7DDE5);
  static const Color grey = Color(0xff8D98AA);
  static const Color greyDark = Color(0xff666666);

  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);

  // ===== TEXT BASE =====
  static const Color textDark = Color(0xFF1c1c1c);
  static const Color textGrey = Color(0xFF8D98AA);
  static const Color textLight = Color(0xFFFFFFFF);

  // ===== STATUS =====
  static const Color success = Color(0xff22C55E);
  static const Color error = Color(0xffEF4444);
  static const Color warning = Color(0xffF59E0B);
  static const Color info = Color(0xff3B82F6);

  // ===== BORDER BASE =====
  static const Color borderColor = Color(0xffE6E7E9);
  static const Color borderGrey = Color(0xffD7DDE5);
}