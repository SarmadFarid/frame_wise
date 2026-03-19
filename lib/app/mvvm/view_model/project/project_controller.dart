import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
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
  TextEditingController renameController = TextEditingController(); 
   

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
      // delete from list
      projects.removeWhere(
        (i) => i.projectId.toString() == projectId.toString(),
      );
      // delete form local database
      await storageService.deleteProject(projectId);
      final videoHash = projectId.split('_').last;
      final projectDirPath = '${dir.path}/projects/$projectId';
      final frameCacheDir = Directory('${dir.path}/frame_cache/$videoHash');
      final projectsDirectory = Directory(projectDirPath);

      // delete project folder directory
      if (await projectsDirectory.exists()) {
        await projectsDirectory.delete(recursive: true);
        LoggerService.i('Folder $projectDirPath and its contents deleted.');
      } else {
        LoggerService.w('Folder $projectDirPath does not exist.');
      }

      // delete frame cache folder directory
      if (await frameCacheDir.exists()) {
        await frameCacheDir.delete(recursive: true);
        LoggerService.i(
          'Folder ${frameCacheDir.path} and its contents deleted.',
        );
      } else {
        LoggerService.w('Folder ${frameCacheDir.path} does not exist.');
      }
    } catch (e, stack) {
      LoggerService.e(
        'Error deleting project',
        error: e.toString(),
        stackTrace: stack,
      );
    }
  }

  Future<void> renameProject({
    required String projectId,
    required String newName,
  }) async {
    try {
      final index = projects.indexWhere((p) => p.projectId == projectId);
      //  rename in current list
      LoggerService.i('renaming project');
      var renameProject = projects[index].toJson();
      renameProject['title'] = newName;
      projects[index] = ProjectJsonModel.fromJson(renameProject);
      projects.refresh();
      // rename in local data base
      await storageService.renameProject(
        projectId: projectId,
        newName: newName,
      );
      LoggerService.i('project rename successfully');
    } catch (e, stack) {
      LoggerService.e(
        'Error rename project',
        error: e.toString(),
        stackTrace: stack,
      );
    }
  }

  String formatDate(DateTime dateStr) {
    return DateFormat('dd MMM, yyyy').format(dateStr);
  }
}
