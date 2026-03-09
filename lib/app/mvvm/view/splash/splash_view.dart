import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/utills/app_assets.dart';
import 'package:frame_wise/app/core/utills/app_routes.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_button.dart';
import 'package:frame_wise/app/widgets/custom_rich_text.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';

class SplashIntroScreen extends StatefulWidget {
  const SplashIntroScreen({Key? key}) : super(key: key);

  @override
  State<SplashIntroScreen> createState() => _SplashIntroScreenState();
}

class _SplashIntroScreenState extends State<SplashIntroScreen> {
  int _currentIndex = 0;

  final List<String> images = [
    AppImages.slideOne,
    AppImages.sllideTwo,
    AppImages.slideOne,
    AppImages.sllideTwo,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              /// -------- LOGO SECTION ----------
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  AppImages.appLogo,
                  fit: BoxFit.cover,
                  width: 160.w,
                ),
              ),

              SizedBox(height: 40.h),

              /// -------- HEADING ----------
              SizedBox(
                width: Get.width * 0.85,

                child: CustomRichText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  firstTextStyle: context.themeText.titleLarge?.copyWith(
                    color: context.colors.textBrand,
                  ),
                  secondTextStyle: context.themeText.titleLarge?.copyWith(
                    color: context.colors.textPrimary,
                  ),
                  thirdTextStyle: context.themeText.titleLarge?.copyWith(
                    color: context.colors.textBrand,
                  ),
                  firstText: 'Real-Time Error ',
                  secondText: 'Detection & ',
                  thirdText: 'Analysis Report.',
                ),
              ),

              SizedBox(height: 40.h),

              /// -------- CAROUSEL ----------
              CarouselSlider(
                options: CarouselOptions(
                  height: 410.h,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: images.map((imagePath) {
                  return Container(
                    margin: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: context.colors.surfaceCard,
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.brandPrimary.withOpacity(0.5),
                          blurRadius: 4.r,

                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: Get.width * 0.70,
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 20.h),

              /// -------- DOT INDICATOR ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  return Container(
                    width: _currentIndex == entry.key ? 16.w : 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: _currentIndex == entry.key
                          ? context.colors.textBrand
                          : context.colors.borderDefault,
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              CustomButton(
                text: 'Get Started',
                onPressed: () {
                  Get.toNamed(AppRoutes.signupView);
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
