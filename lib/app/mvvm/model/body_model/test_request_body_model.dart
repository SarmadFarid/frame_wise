import 'dart:io';

/// Test request model with basic multipart structure.
class TestRequestBodyModel {
  String? note;
  File? image;

  TestRequestBodyModel({this.note, this.image});

  Map<String, dynamic> toJson() => {'note': note};
}
