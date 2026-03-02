/// Basic test body model (JSON only).
class TestBodyModel {
  String? name;
  String? email;

  TestBodyModel({
    this.name,
    this.email,
  });

  factory TestBodyModel.fromJson(Map<String, dynamic> json) => TestBodyModel(
        name: json['name'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
