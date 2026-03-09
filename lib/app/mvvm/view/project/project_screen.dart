import 'package:flutter/material.dart';
import 'package:frame_wise/app/mvvm/view_model/project/project_controller.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/cards/project_cards.dart';
import 'package:frame_wise/app/widgets/custom_rich_text.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';
import 'package:get/get.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();

    return Scaffold(
      backgroundColor: context.colors.bgPrimary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top Header Section
            _buildHeader(context, controller),

            // Today Section
            ProjectCards.buildSectionTitle(context, 'Today'),
            Obx(
              () => controller.isGridView.value
                  ? _buildGrid(context, controller.todayProjects, true)
                  : _buildList(context, controller.todayProjects, true),
            ),

            // Earlier Section
            ProjectCards.buildSectionTitle(context, 'Earlier'),
            Obx(
              () => controller.isGridView.value
                  ? _buildGrid(context, controller.earlierProjects, false)
                  : _buildList(context, controller.earlierProjects, false),
            ),

            // Bottom Padding
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
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
            Obx(
              () => IconButton(
                onPressed: () => controller.toggleView(),
                icon: Icon(
                  controller.isGridView.value
                      ? Icons.list
                      : Icons.grid_view_rounded,
                  color: context.colors.textGrey,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),

            ProjectCards.buildSortDropdown(context, controller),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: context.colors.borderLight),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CustomText(
                    "View All",
                    style: context.themeText.bodySmall?.copyWith(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.list_alt,
                    size: 14,
                    color: context.colors.textDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build List View
  Widget _buildList(BuildContext context, List<dynamic> items, bool isToday) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ProjectCards.buildListTile(
          context: context,
          data: items[index],
          subtitle: isToday ? items[index]['time']! : items[index]['date']!,
        ),
        childCount: items.length,
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<dynamic> items, bool isToday) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.9,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => ProjectCards.buildGridTile(
            context: context,
            data: items[index],
            subtitle: isToday ? items[index]['time']! : items[index]['date']!,
          ),
          childCount: items.length,
        ),
      ),
    );
  }
}
