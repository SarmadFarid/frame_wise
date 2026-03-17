import 'dart:convert';
import 'dart:io';

import 'package:frame_wise/app/mvvm/model/video_models.dart';
import 'package:frame_wise/app/services/logger_service.dart';
import 'package:frame_wise/app/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

enum SortOption { name, date, size }

class ProjectController extends GetxController {
  StorageService storageService = StorageService.instance;
  var projects = <ProjectJsonModel>[].obs;
  var isloading = false.obs;
  var selectedSort = SortOption.name.obs;
  var isGridView = false.obs;

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void updateSort(SortOption option) {
    selectedSort.value = option;
  }

  @override
  void onInit() {
    loadAllProjects();
    super.onInit();
  }

  Future<void> loadAllProjects() async {
    try {
      isloading(true);
      final List<ProjectJsonModel> data = await storageService.loadProject();
      data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      projects.assignAll(data);
      LoggerService.i(projects);
    } catch (e) {
      LoggerService.e('Error loading saves projects', error: e);
    } finally {
      isloading.value = false;
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      final dir = await getApplicationDocumentsDirectory();

      projects.removeWhere(
        (i) =>
            i.projectId.trim().toLowerCase() == projectId.trim().toLowerCase(),
      );
      final projectDirPath = '${dir.path}/projects/$projectId';

      final projectsDirectory = Directory(projectDirPath);

      if (await projectsDirectory.exists()) {
        await projectsDirectory.delete(recursive: true);
        LoggerService.i('Folder $projectDirPath and its contents deleted.');
      } else {
        LoggerService.w('Folder $projectDirPath does not exist.');
      }
    } catch (e, stack) {
      LoggerService.e(
        'Error deleting project',
        error: e.toString(),
        stackTrace: stack,
      );
    }
  }

  String formatDate(DateTime dateStr) {
    return DateFormat('dd MMM, yyyy').format(dateStr);
  }
}
