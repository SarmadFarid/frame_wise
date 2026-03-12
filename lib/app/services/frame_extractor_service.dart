import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:frame_wise/app/mvvm/model/video_models.dart';
import 'package:path_provider/path_provider.dart';

String computeVideoHash(Map<String, dynamic> data) {
  final size = data['size'];
  final modified = data['modified'];
  final name = data['name'];
  final videoIdentity = "${size}_${modified}_$name";
  return md5.convert(utf8.encode(videoIdentity)).toString();
}

List<String> getSortedFrames(String dirPath) {
  final dir = Directory(dirPath);
  if (!dir.existsSync()) return [];

  final frames = dir
      .listSync()
      .where((f) => f is File && f.path.endsWith('.jpg'))
      .map((f) => f.path)
      .toList();
  frames.sort();
  return frames;
}

class FrameExtractorService {
  static Future<Map<String, dynamic>> extractFrames({
    required String videoPath,
    required String projectDirPath,
    required String projectId,
    required String thumbnailPath,
  }) async {
    try {
      final File videoFile = File(videoPath);
      final dir = await getApplicationDocumentsDirectory();

      final stat = videoFile.statSync();
      final videoHash = await compute(computeVideoHash, {
        'size': stat.size,
        'modified': stat.modified.millisecondsSinceEpoch,
        'name': videoFile.uri.pathSegments.last,
      });

      final frameDir = Directory('${dir.path}/frame_cache/$videoHash');
      final statusFile = File('${frameDir.path}/.extraction_success');
      final proxyPath = '$projectDirPath/proxy.mp4';
      final jsonPath = '$projectDirPath/project.json';

      List<String> extractedFrames = [];

      // If frames already exist → reuse
      if (await statusFile.exists()) {
        log("Frames found in cache. Reusing...");
        extractedFrames = await compute(getSortedFrames, frameDir.path);
      } else {
        log("No cache found. Processing new video...");
      }

      if (await frameDir.exists()) {
        await frameDir.delete(recursive: true);
      }

      await frameDir.create(recursive: true);

      log("Generating Proxy Video...");
      final proxyCmd =
          '-i "$videoPath" -vf "scale=-2:480" -c:v libx264 -preset ultrafast -crf 28 "$proxyPath"';
      final proxySession = await FFmpegKit.execute(proxyCmd);
      final proxyReturnCode = await proxySession.getReturnCode();
      if (!ReturnCode.isSuccess(proxyReturnCode)) {
        throw Exception("Proxy Generation Failed");
      }

      log("Extracting Frames from Proxy...");
      final command =
          '-i "$proxyPath" -vf "fps=2,scale=160:-1" -q:v 3 "${frameDir.path}/frame_%04d.jpg"';

      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        await statusFile.create();

        extractedFrames = await compute(getSortedFrames, frameDir.path);
      } else {
        throw Exception('Frame Extraction Failed');
      }

      final projectData = ProjectJsonModel(
        projectId: projectId,
        title: "New Project",
        videoPath: videoPath,
        proxyPath: proxyPath,
        videoHash: videoHash,
        thumbnail: thumbnailPath,
        fps: 2,
        deletedFrames: [],
        createdAt: DateTime.now(),
      );

      final jsonFile = File(jsonPath);
      await jsonFile.writeAsString(jsonEncode(projectData.toJson()));

      return {'frames': extractedFrames, 'projectData': projectData};
    } catch (e) {
      log("Frame extraction error: $e");
      return {};
    }
  }
}
