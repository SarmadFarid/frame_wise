class FrameModel {
  final int index;
  final String path;
  final double timestamp;
  final bool issueDetected;

  FrameModel({
    required this.index,
    required this.path,
    required this.timestamp,
    this.issueDetected = false,
  });
}

class FrameIssueModel {
  final int frameIndex;
  final String title;
  final String description;
  final String severity;

  FrameIssueModel({
    required this.frameIndex,
    required this.title,
    required this.description,
    required this.severity,
  });
}
 
class ProjectJsonModel {
  final String projectId;
  final String title;
  final String videoPath;
  final String proxyPath;
  final String videoHash;
  final String thumbnail;
  final int fps;
  final List deletedFrames;
  final DateTime createdAt;

  ProjectJsonModel({
    required this.projectId,
    required this.title,
    required this.videoPath,
    required this.proxyPath,
    required this.videoHash,
    required this.thumbnail,
    required this.fps,
    required this.deletedFrames,
    required this.createdAt,
  });

  factory ProjectJsonModel.fromJson(Map<String, dynamic> json) {
    return ProjectJsonModel(
      projectId: json['projectId'] as String? ?? "",
      title: json['title'] as String? ?? "" ,
      videoPath: json['videoPath'] as String? ?? "" ,
      proxyPath: json['proxyPath'] as String? ?? "" ,
      videoHash: json['videoHash'] as String? ?? "",
      thumbnail: json['thumbnail'] as String? ?? "" ,
      fps: json['fps'] as int ,
      deletedFrames:json['deletedFrames'] ?? [] ,
      createdAt: json['createdAt'] is String ? DateTime.parse(json['createdAt']) : json['createdAt'] as DateTime ,
    );
  }

  Map<String, dynamic> toJson() => {
    "projectId": projectId,
    "title": title,
    "videoPath": videoPath,
    "proxyPath": proxyPath,
    "videoHash": videoHash,
    "thumbnail": thumbnail,
    "fps": fps,
    "deletedFrames": deletedFrames,
    "createdAt": createdAt.toIso8601String(),
  };
}



