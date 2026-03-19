import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/mvvm/model/video_models.dart';
import 'package:frame_wise/app/mvvm/view_model/project/project_controller.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_button.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:frame_wise/app/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProjectCards {
  static Widget buildSortDropdown(
    BuildContext context,
    ProjectController controller,
  ) {
    return PopupMenuButton<SortOption>(
      offset: const Offset(0, 45),
      // Fix: Removed alpha to remove glass effect. Using a solid theme color.
      color: context.colors.infoContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      icon: Icon(Icons.sort_by_alpha, color: context.colors.textGrey, size: 20),
      onSelected: (SortOption item) => controller.updateSort(item),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOption>>[
        // Title Item (Non-clickable)
        PopupMenuItem<SortOption>(
          enabled: false,
          child: CustomText(
            "Sort by:",
            style: context.themeText.bodyMedium?.copyWith(
              color: context.colors.brandSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildSortItem(
          context,
          SortOption.name,
          "Name",
          controller.selectedSort.value,
        ),
        _buildSortItem(
          context,
          SortOption.date,
          "Date",
          controller.selectedSort.value,
        ),
        _buildSortItem(
          context,
          SortOption.size,
          "Size",
          controller.selectedSort.value,
        ),
      ],
    );
  }

  static PopupMenuItem<SortOption> _buildSortItem(
    BuildContext context,
    SortOption value,
    String label,
    SortOption currentSelection,
  ) {
    bool isSelected = value == currentSelection;
    return PopupMenuItem<SortOption>(
      value: value,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: isSelected
                ? Icon(
                    Icons.done_all,
                    size: 18,
                    color: context.colors.brandSecondary,
                  )
                : null,
          ),
          const SizedBox(width: 8),
          CustomText(
            label,
            style: context.themeText.bodyMedium?.copyWith(
              color: context.colors.brandSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildSectionTitle(
    BuildContext context,
    String title,
    ProjectController controller,
  ) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: CustomText(
          title,
          style: context.themeText.titleMedium?.copyWith(
            color: context.colors.brandSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Widget buildListTile({
    required BuildContext context,
    required ProjectJsonModel data,
    required String subtitle,
    required VoidCallback ontapRename,
    required VoidCallback ontapView,
    required VoidCallback ontapExport,
    required VoidCallback ontapRemove,
  }) {
    // Thumbnail path nikalna
    final String imagePath = data.thumbnail;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colors.borderLight.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              width: 60.w,
              height: 50.h,
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.colors.bgSecondary),
                child: imagePath.isNotEmpty
                    ? Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) => Icon(
                          Icons.broken_image,
                          size: 20.sp,
                          color: context.colors.textGrey,
                        ),
                      )
                    : Icon(Icons.image, color: context.colors.textLightGrey),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: CustomText(
              data.title,
              style: context.themeText.bodyMedium?.copyWith(
                color: context.colors.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          CustomText(
            subtitle,
            style: context.themeText.bodySmall?.copyWith(
              color: context.colors.textGrey,
            ),
          ),
          _buildProjectPopupMenu(
            context,
            ontapRename: ontapRename,
            ontapView: ontapView,
            ontapExport: ontapExport,
            ontapRemove: ontapRemove,
          ),
        ],
      ),
    );
  }

  static Widget buildGridTile({
    required BuildContext context,
    required ProjectJsonModel data,
    required String subtitle,
    required VoidCallback ontapRename,
    required VoidCallback ontapView,
    required VoidCallback ontapExport,
    required VoidCallback ontapRemove,
  }) {
    final String imagePath = data.thumbnail;
    final String title = data.title;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.colors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
              child: SizedBox(
                // height: 60.h,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: context.colors.bgSecondary),
                  child: imagePath.isNotEmpty
                      ? Image.file(
                          File(imagePath),
                          fit: BoxFit.cover,
                          errorBuilder: (context, _, __) => Icon(
                            Icons.broken_image,
                            color: context.colors.textLightGrey,
                          ),
                        )
                      : Icon(Icons.image, color: context.colors.textLightGrey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        title,
                        style: context.themeText.bodyMedium?.copyWith(
                          color: context.colors.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: _buildProjectPopupMenu(
                        context,
                        ontapRename: ontapRename,
                        ontapView: ontapView,
                        ontapExport: ontapExport,
                        ontapRemove: ontapRemove,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                CustomText(
                  subtitle,
                  style: context.themeText.bodySmall?.copyWith(
                    color: context.colors.textGrey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildProjectPopupMenu(
    BuildContext context, {
    required VoidCallback ontapRename,
    required VoidCallback ontapView,
    required VoidCallback ontapExport,
    required VoidCallback ontapRemove,
  }) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_vert, color: context.colors.textGrey, size: 20),
      color: context.colors.surfaceElevated,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        debugPrint("Selected action: $value");
      },
      itemBuilder: (context) => [
        _buildActionMenuItem(
          context,
          Icons.edit_outlined,
          "Rename",
          "rename",
          ontapRename,
        ),
        _buildActionMenuItem(
          context,
          Icons.visibility_outlined,
          "View",
          "view",
          ontapView,
        ),
        _buildActionMenuItem(
          context,
          Icons.ios_share,
          "Export",
          "export",
          ontapExport,
        ),
        _buildActionMenuItem(
          context,
          Icons.delete_outline,
          "Remove",
          "remove",
          ontapRemove,
          isDestructive: true,
        ),
      ],
    );
  }

  static PopupMenuItem<String> _buildActionMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback ontap, {
    bool isDestructive = false,
  }) {
    return PopupMenuItem<String>(
      value: value,
      onTap: ontap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isDestructive
                ? context.colors.error
                : context.colors.textDark,
          ),
          const SizedBox(width: 12),
          CustomText(
            label,
            style: context.themeText.bodyMedium?.copyWith(
              color: isDestructive
                  ? context.colors.error
                  : context.colors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  static void showRenameDialog(
    BuildContext context,
    ProjectController controller,
    String projectId,
  ) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),

        elevation: 2,
        child: Container(
          width: Get.width * 0.85,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: context.colors.surfacePrimary,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [BoxShadow(color: Colors.white, blurRadius: 6.r)],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                textAlign: TextAlign.center,
                'Rename Your Project',
                style: context.themeText.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colors.textBrand,
                ),
              ),
              SizedBox(height: 3.h),
              CustomText(
                'Enter the name you used to rename the project',
                textAlign: TextAlign.center,
                style: context.themeText.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colors.textDark.withValues(alpha: 0.7),
                ),
              ),

              SizedBox(height: 30.h),
              CustomTextField(
                label: 'New Name',
                hint: 'enter your new name',
                prefixIcon: Icons.text_snippet_outlined,
              ),

              SizedBox(height: 10.h),

              CustomButton(
                text: 'Save',
                onPressed: () async {
                  await controller.renameProject(
                    projectId: projectId,
                    newName: 'New name' ,
                  );
                  Get.back();
                },
                bgColor: context.colors.brandPrimary,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showEmailSendDialog(BuildContext context) {}
}
