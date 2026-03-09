import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/mvvm/view_model/settings/profile_controller.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/cards/profile_cards.dart';
import 'package:frame_wise/app/widgets/custom_button.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:frame_wise/app/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

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
              SizedBox(height: 10.h),

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

              SizedBox(height: 30.h),

              CustomText(
                'Your Profile',
                style: context.themeText.headlineMedium?.copyWith(
                  color: context.colors.textBrand,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: 45.h),

              // --- FORM SECTION ---
              CustomTextField(
                label: "Full name",
                initialValue: 'Sarmad Farid',
                hint: "Enter your Full name",
                readOnly: true,
                prefixIcon: Icons.person,
                suffixWidget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: context.colors.success,
                    size: 15.sp,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: "Email",
                initialValue: 'sarmad@gamil.com',
                hint: "Enter your email address",
                readOnly: true,
                prefixIcon: Icons.mail,
                suffixWidget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: context.colors.success,
                    size: 15.sp,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: "Password",
                hint: "Enter your Password",
                prefixIcon: Icons.lock,
                isPassword: true,
                readOnly: true,
                initialValue: '*********',
                suffixWidget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: context.colors.success,
                    size: 15.sp,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  ProfileCards.showChangePassDialog(context);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    'Change Password',
                    style: context.themeText.labelLarge?.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              CustomTextField(
                label: "Phone Number",
                hint: "enter your number",
                prefixIcon: Icons.phone,
                initialValue: '03** 88888888',
                readOnly: true,
                suffixWidget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: context.colors.success,
                    size: 15.sp,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              Obx(
                () => CustomTextField(
                  label: "Bio",
                  hint: "your bio",
                  maxLines: 4,
                  focusNode: controller.bioFocus,
                  prefixIcon: Icons.description_outlined,
                  initialValue: 'i am passionate flutter developer',

                  readOnly: controller.readOnly.value,
                  suffixWidget: IconButton(
                    onPressed: () {
                      controller.readOnly.value = false;
                      controller.bioFocus.requestFocus();
                    },
                    icon: Icon(
                      Icons.edit,
                      color: context.colors.success,
                      size: 15.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50.h),

              // --- BUTTON SECTION ---
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      bgColor: context.colors.brandPrimary,
                      text: "Update Profile",
                      onPressed: () {
                        // Controller logic
                        // print("Registering user...");
                      },
                    ),
                  ),
                  SizedBox(width: 8.h),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: CustomText(
                        'Reset',
                        style: context.themeText.labelLarge?.copyWith(
                          color: context.colors.textBrand,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
