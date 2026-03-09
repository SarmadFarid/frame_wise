import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? height;
  final bool? softWrap;
  final bool? selectable;

  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.softWrap,
    this.selectable,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ?? context.themeText.bodyMedium;

    final TextStyle finalStyle = baseStyle!.copyWith(
      fontFamily: context.fontFamily,
      fontSize: fontSize?.sp ?? baseStyle.fontSize,
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      color: color ?? baseStyle.color,
      letterSpacing: letterSpacing ?? baseStyle.letterSpacing,
      height: height ?? baseStyle.height,
    );

    if (selectable == true) {
      return SelectableText(
        text,
        style: finalStyle,
        textAlign: textAlign,
        maxLines: maxLines,
      );
    }

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap ?? true,
    );
  }
}
