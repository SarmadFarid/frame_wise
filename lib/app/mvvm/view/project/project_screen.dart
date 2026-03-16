import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/mvvm/model/video_models.dart';
import 'package:frame_wise/app/mvvm/view_model/project/project_controller.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/cards/project_cards.dart';
import 'package:frame_wise/app/widgets/custom_rich_text.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Date formatting ke liye

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();

    return Scaffold(
      backgroundColor: context.colors.bgPrimary,
      body: SafeArea(
        child: Obx(() {
          if (controller.isloading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          

          return CustomScrollView(
            slivers: [
              _buildHeader(context, controller),

              ProjectCards.buildSectionTitle(context, 'Your Projects', controller),
                 
              controller.isGridView.value
                  ? _buildGrid(context, controller.projects)
                  : _buildList(context, controller.projects),

              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProjectController controller) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CustomRichText(
              firstText: 'Frame',
              secondText: 'Wise',
              style: context.themeText.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            // Grid / List View Toggle Button
            IconButton(
              onPressed: () => controller.toggleView(),
              icon: Icon(
                controller.isGridView.value
                    ? Icons.list
                    : Icons.grid_view_rounded,
                color: context.colors.textGrey,
                size: 22,
              ),
            ),
            const SizedBox(width: 8),
            ProjectCards.buildSortDropdown(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<ProjectJsonModel> items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final project = items[index];
        return ProjectCards.buildListTile(
          context: context,
          data: project,
          subtitle: _formatDate(project.createdAt),
        );
      }, childCount: items.length),
    );
  }

  Widget _buildGrid(BuildContext context, List<ProjectJsonModel> items) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final project = items[index];
          return ProjectCards.buildGridTile(
            context: context,
            data: project,
            subtitle: _formatDate(project.createdAt),
          );
        }, childCount: items.length),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.video_library_outlined,
            size: 60,
            color: context.colors.textGrey,
          ),
          SizedBox(height: 10.h),
          CustomText("No projects yet", style: context.themeText.bodyMedium),
        ],
      ),
    );
  }

  // Date ko khubsurat dikhane ke liye helper
  String _formatDate(DateTime dateStr) {
    return DateFormat('dd MMM, yyyy').format(dateStr);
  }
  
}
