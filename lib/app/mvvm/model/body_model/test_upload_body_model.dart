import 'dart:io';

/// Test body model with single file upload support.
class TestUploadBodyModel {
  String? title;
  File? file;

  TestUploadBodyModel({
    this.title,
    this.file,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
      };
}
