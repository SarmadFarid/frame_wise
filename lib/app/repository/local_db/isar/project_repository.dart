// import 'package:frame_wise/app/mvvm/model/project_model.dart';
// import 'package:frame_wise/app/services/isar/isar_service.dart';
// import 'package:isar/isar.dart';

// class ProjectRepository {

//   Future<void> saveProject(ProjectModel project) async {
//     final isar = IsarService.isar;
//     await isar.writeTxn(() async {
//       await isar.projectModels.put(project);
//     });
//   }


//   Future<List<ProjectModel>> getProjects() async {
//     final isar = IsarService.isar;
//     return await isar.projectModels.where().findAll();
//   }



// }

