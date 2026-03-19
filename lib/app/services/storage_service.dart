import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:frame_wise/app/mvvm/model/video_models.dart';
import 'package:frame_wise/app/mvvm/view_model/project/project_controller.dart';
import 'package:frame_wise/app/services/logger_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  StorageService._();
  static StorageService instance = StorageService._();

  final box = GetStorage();
  final String projectKey = 'all_projects';

  Future<Directory> createProjectDirectory(String projectId) async {
    final dir = await getApplicationDocumentsDirectory();
    final projectsDirectory = Directory('${dir.path}/projects');
    if (!await projectsDirectory.exists()) {
      await projectsDirectory.create(recursive: true);
    }

    // final  projectId = DateTime.now().microsecondsSinceEpoch ;
    final projectDir = Directory(
      '${projectsDirectory.path}/project_$projectId',
    );
    if (!await projectDir.exists()) {
      await projectDir.create(recursive: true);
    }

    return projectDir;
  }

  Future<void> saveProject(
    ProjectJsonModel project,
    ProjectController controller,
  ) async {
    LoggerService.i(
      "Saving project : ${project.title} | Deleted Frames: ${project.deletedFrames}",
    );

    //  updata ui state
    int ctrlIndex = controller.projects.indexWhere(
      (p) => p.projectId.toString() == project.projectId.toString(),
    );
    if (ctrlIndex != -1) {
      controller.projects[ctrlIndex] = project;
    } else {
      controller.projects.add(project);
    }

    // update Local Database
    dynamic storedData = box.read(projectKey);
    List<dynamic> projects = storedData is List ? List.from(storedData) : [];

    int dbIndex = projects.indexWhere(
      (p) => p['projectId'].toString() == project.projectId.toString(),
    );
    if (dbIndex != -1) {
      projects[dbIndex] = project.toJson();
      LoggerService.i("Project updated in local database.");
    } else {
      projects.add(project.toJson());
      LoggerService.i("New project added to local database.");
    }

    await box.write(projectKey, projects);
    LoggerService.i(
      "Saved successfully! Total projects in DB: ${projects.length}",
    );
  }

  Future<void> deleteProject(String projectId) async {
    dynamic storedData = box.read(projectKey);
    List<dynamic> projects = storedData is List ? List.from(storedData) : [];

    LoggerService.i(
      'stored project lenght before deleting : ${projects.length}',
    );
    log('first project : ${projects.first}');
    projects.removeWhere(
      (p) => p['projectId'].toString() == projectId.toString(),
    );
    LoggerService.i(' after deleting projects length : ${projects.length}');
    await box.write(projectKey, projects);
  }

  Future<void> renameProject({
    required String projectId,
    required String newName,
  }) async {
    dynamic storedData = box.read(projectKey);
    List<dynamic> projects = storedData is List ? List.from(storedData) : [];
    final index = projects.indexWhere(
      (p) => p['projectId'].toString() == projectId.toString(),
    );
    if (index != -1) {
      projects[index]['title'] = newName;
      await box.write(projectKey, projects);
      LoggerService.i('Project renamed successfully in DB');
    } else {
      LoggerService.w('Project not found for renaming');
    }

    await box.write(projectKey, projects);
  }

  Future<List<ProjectJsonModel>> loadProject() async {
    List data = box.read(projectKey) ?? [];
    LoggerService.i('data length: ${data.length}');
    return data.map((e) => ProjectJsonModel.fromJson(e)).toList();
  }
}
