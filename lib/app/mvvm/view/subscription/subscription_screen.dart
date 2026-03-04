import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/widgets/cards/subscription_cards.dart';
import 'package:frame_wise/app/theme/app_fonts_config.dart';
import 'package:frame_wise/app/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_rich_text.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 5.h),

              GestureDetector(
                onTap: () => Get.back(),
                child: SizedBox(
                  height: 25.h,
                  width: 25.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.bgInverse,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: context.colors.textInverse,
                        size: 15.sp,
                      ),
                    ),
                  ),
                ),
              ),

               SizedBox(height: 20.h),
              CustomRichText(
                maxLines: 4,
                textAlign: TextAlign.center,
                firstText: '"Every flaw. Every frame. Automatically detected."',
                secondText: ' Deliver cleaner, sharper videos with',
                thirdText: ' FrameWise.',
                style: context.themeText.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                       ), 
                    
              ),
              

              SizedBox(height: 30.h),

              CustomText(
                "Choose Plan Go Premium",
                style: context.themeText.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: context.colors.textDark,
                  fontFamily: FontFamily.inter, 
                  wordSpacing: -1.5
                ),
              ),

              SizedBox(height: 25.h),

              /// ---------- PRICING CARDS ----------
              SubscriptionCard(
                title: "Starter",
                price: "\$7",
                duration: "/Month",
                features: const [
                  "Get 3 analysis per project",
                  "Save up to 5 projects",
                ],
                isHighlighted: true,
                buttonText: "Start 14 days free plan",
              ),

              SubscriptionCard(
                title: "Animator",
                price: "\$15",
                duration: "/Month",
                features: const [
                  "Get 10 analysis per project",
                  "Save up to 15 projects",
                  "Save, export and share reports",
                  "Basic AI detection",
                ],
                isHighlighted: false,
                buttonText: "Subscribe Now",
              ),

              SubscriptionCard(
                title: "Pro",
                price: "\$25",
                duration: "/Month",
                features: const [
                  "Unlimited analysis and save projects.",
                  "Save, export and review analysis.",
                  "Receive more specific recommendations.",
                  "AI chatbot for more guidance on improvement.",
                  "Upload adobe or MP4 files for review.",
                ],
                isHighlighted: false,
                buttonText: "Upgrade to Pro",
              ),

              SubscriptionCard(
                title: "Team",
                price: "\$50",
                duration: "/Month",
                features: const [
                  "Upto 10 Users.",
                  "All pro features +. Limitless uploads.",
                  "Dashboard for collaboration and updates.",
                  "Shared accounts and comment features for frames.",
                  "Notes feature for project tracking and progress.",
                ],
                isHighlighted: false,
                buttonText: "Subscribe Now",
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
