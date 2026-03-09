import 'package:flutter/material.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';

class CustomRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String? thirdText;

  // Optional overrides
  final TextStyle? style;
  final TextStyle? firstTextStyle;
  final TextStyle? secondTextStyle;
  final TextStyle? thirdTextStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const CustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.thirdText,
    this.style,
    this.firstTextStyle,
    this.secondTextStyle,
    this.thirdTextStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    // Base styles from your AppTypography
    final baseStyle = style ?? context.themeText.bodyMedium!;

    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      softWrap: softWrap ?? true,
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style:
                firstTextStyle ??
                baseStyle.copyWith(
                  color: context.colors.textBrand,
                  fontWeight: FontWeight.w500,
                ),
          ),
          TextSpan(
            text: secondText,
            style:
                secondTextStyle ??
                baseStyle.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (thirdText != null)
            TextSpan(
              text: thirdText,
              style:
                  thirdTextStyle ??
                  baseStyle.copyWith(
                    color: context.colors.textBrand,
                    fontWeight: FontWeight.w500,
                  ),
            ),
        ],
      ),
    );
  }
}
