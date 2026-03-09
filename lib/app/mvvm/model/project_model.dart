import 'package:isar/isar.dart';
part 'project_model.g.dart';

@collection
class ProjectModel {

  Id id = Isar.autoIncrement;

  late String title;

  late String videoPath;

  late String thumbnail;

  late DateTime createdAt;

}