import 'dart:io';

/// Test multipart model showing all common file fields.
class TestMultipartBodyModel {
  String? title;
  File? image;
  File? document;
  List<File>? documents;

  TestMultipartBodyModel({
    this.title,
    this.image,
    this.document,
    this.documents,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
      };
}
