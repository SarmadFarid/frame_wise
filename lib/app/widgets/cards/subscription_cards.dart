import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_button.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String duration;
  final List<String> features;
  final bool isHighlighted;
  final String buttonText;

  const SubscriptionCard({
    Key? key,
    required this.title,
    required this.price,
    required this.duration,
    required this.features,
    required this.isHighlighted,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color cardColor = isHighlighted
        ? context.colors.brandPrimary
        : context.colors.brandSecondary;

    final Color textColor = isHighlighted ? Colors.black : Colors.white;

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: context.colors.brandPrimary.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.brandPrimary.withOpacity(0.5),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Plan Title + Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title,
                style: context.themeText.titleLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 22.sp,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: price,
                  style: context.themeText.titleLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: duration,
                      style: context.themeText.bodyMedium?.copyWith(
                        color: textColor.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 22.h),

          CustomText(
            'Plan includes :',
            style: context.themeText.labelLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 15.h),

          /// Features
          ...features.map(
            (feature) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 18.sp,
                    color: isHighlighted
                        ? Colors.white
                        : context.colors.textPrimary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomText(
                      feature,
                      style: context.themeText.bodyMedium?.copyWith(
                        color: textColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 30.h),

          /// Button
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              textColor: isHighlighted
                  ? Colors.white
                  : context.colors.brandSecondary,
              bgColor: isHighlighted
                  ? context.colors.brandSecondary
                  : Colors.white,
              text: buttonText,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
