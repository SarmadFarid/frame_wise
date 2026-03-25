import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/utills/app_assets.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/mvvm/view_model/project/project_controller.dart';
import 'package:frame_wise/app/core/utills/app_routes.dart';
import 'package:frame_wise/app/widgets/custom_rich_text.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();
    final colors = context.colors;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRichText(
                    firstText: 'Frame',
                    secondText: 'Wise',
                    style: context.themeText.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.textDark,
                          blurRadius: 5.r,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: colors.surfaceCard,
                      child: Icon(Icons.person, color: colors.textPrimary),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// Hero Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.brandPrimary,
                      blurRadius: 5.r,
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage(AppImages.banner),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Analyze Your Videos And \nDetect Any Issues",
                      style: context.themeText.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    CustomText(
                      "Upload videos and automatically detect\nframe issues.",
                      style: context.themeText.bodySmall?.copyWith(
                        color: context.colors.textDark,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    ElevatedButton.icon(
                      onPressed: () {
                        Get.toNamed(AppRoutes.importvideoScren);
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        "New Project",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.brandPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              /// Recent Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.loadAllProjects(),
                    child: CustomText(
                      "Recent Projects",
                      style: context.themeText.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  TextButton(onPressed: () {}, child: const Text("View All")),
                ],
              ),

              SizedBox(height: 10.h),

              /// Recent Projects List
              SizedBox(
                height: 170.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.projects.length,
                  itemBuilder: (context, index) {
                    final project = controller.projects[index];
                    final date = controller.formatDate(project.createdAt);
                    return Container(
                      width: 140.w,
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: colors.surfaceCard,
                        border: Border.all(color: colors.borderLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Thumbnail
                          SizedBox(
                            height: 110.h,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12.r),
                                ),
                                color: colors.brandPrimary.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                              child: Center(
                                child: project.thumbnail.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12.r),
                                        ),
                                        child: Image.file(
                                          File(project.thumbnail),
                                          fit: BoxFit.cover,
                                          // height: 80.h,
                                          width: double.infinity,
                                          errorBuilder: (context, _, __) =>
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 14.h,
                                                  horizontal: 8.w,
                                                ),
                                                child: Image.asset(
                                                  AppImages.zipImage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.image,
                                        color: context.colors.surfaceCard,
                                      ),
                              ),
                            ),
                          ),
                          Divider(
                            color: context.colors.borderLight,
                            height: 1.h,
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  maxLines: 1, 
                                  project.title,
                                  style: context.themeText.labelLarge?.copyWith(fontWeight: FontWeight.w500),
                                ),

                                CustomText(
                                  date,
                                  style: context.themeText.bodySmall?.copyWith(
                                    color: colors.textDark.withValues(alpha: 0.4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
