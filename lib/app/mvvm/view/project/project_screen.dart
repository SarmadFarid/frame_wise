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

              ProjectCards.buildSectionTitle(
                context,
                'Your Projects',
                controller,
              ),

              controller.isGridView.value
                  ? _buildGrid(context, controller)
                  : _buildList(context, controller),

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

  Widget _buildList(BuildContext context, ProjectController controller) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final project = controller.projects[index];
        return ProjectCards.buildListTile(
          context: context,
          data: project,
          subtitle: _formatDate(project.createdAt),
          ontapRename: () {},
          ontapView: () {},
          ontapExport: () {},
          ontapRemove: () {
            controller.deleteProject(project.projectId);
          },
        );
      }, childCount: controller.projects.length),
    );
  }

  Widget _buildGrid(BuildContext context, ProjectController controller) {
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
          final project = controller.projects[index];
          return ProjectCards.buildGridTile(
            context: context,
            data: project,
            subtitle: _formatDate(project.createdAt),
            ontapRename: () {},
            ontapView: () {},
            ontapExport: () {},
            ontapRemove: () {
              controller.deleteProject(project.projectId);
            },
          );
        }, childCount: controller.projects.length),
      ),
    );
  }

  // Date ko khubsurat dikhane ke liye helper
  String _formatDate(DateTime dateStr) {
    return DateFormat('dd MMM, yyyy').format(dateStr);
  }
}
