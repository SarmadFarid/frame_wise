import 'dart:convert';
import 'dart:io';

import 'package:frame_wise/app/mvvm/model/video_models.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {

  static Future<Directory> createProjectDirectory() async {
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


  static Future<void> saveProject(
    Directory projectDir,
    ProjectJsonModel project,
  ) async {
    final file = File('${projectDir.path}/project.json');

    await file.writeAsString(jsonEncode(project.toJson()), flush: true);
  }


  static Future<ProjectJsonModel> loadProject(Directory projectDir) async {
    final file = File('${projectDir.path}/project.json');
    final json = jsonDecode(await file.readAsString());

    return ProjectJsonModel.fromJson(json);
  }


  
}
