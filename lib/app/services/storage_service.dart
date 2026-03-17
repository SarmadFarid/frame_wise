import 'dart:convert';
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

  Future<Directory> createProjectDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final projectsDirectory = Directory('${dir.path}/projects');
    if (!await projectsDirectory.exists()) {
      await projectsDirectory.create(recursive: true);
    }

    final projectId = DateTime.now().millisecondsSinceEpoch;
    final projectDir = Directory(
      '${projectsDirectory.path}/project_$projectId',
    );
    if (!await projectDir.exists()) {
      await projectDir.create(recursive: true);
    }

    return projectDir;
  }

  Future<void> saveProject(ProjectJsonModel project, ProjectController controller) async {
    LoggerService.i("deleted frames  : ${project.deletedFrames}");
    controller.projects.add(project);  
    
    dynamic storedData = box.read(projectKey);
    // LoggerService.i('stroed data : $storedData');
    List<dynamic> projects = [];
    if (storedData is List) {
      projects = List.from(storedData);
    } else {
      LoggerService.i("Old data was Map/Corrupted. Starting fresh list.");
    }
    projects.add(project.toJson());
    // LoggerService.i('projects: $projects');
    await box.write(projectKey, projects);
    LoggerService.i(
      "Saved successfully! Total projects in DB: ${projects.length}",
    );
  }

  Future<List<ProjectJsonModel>> loadProject() async {  
    List data = box.read(projectKey) ?? [];
    LoggerService.i('data : $data');  
    return data.map((e) => ProjectJsonModel.fromJson(e)).toList();
  }
}
