import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:frame_wise/app/services/logger_service.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoServices {
  VideoServices._();
  static VideoServices instance = VideoServices._();

  Future<String?> generateThumbnail(
    String videoPath,
    String projectDirPath,
  ) async {
    final thumb = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      quality: 100,
      thumbnailPath: projectDirPath,
    );
    if (thumb == null) return null;
    final newthumbnailPath = '$projectDirPath/thumb.png';
    await File(thumb).rename(newthumbnailPath);
    return newthumbnailPath;
  }

  Future<bool> generateProxyVideo({
    required String originalPath,
    required String proxyPath,
    required Function(double progress) onProgress,
  }) async {
    final File proxyFile = File(proxyPath);
    final   completer = Completer<bool>(); 
    if (!proxyFile.parent.existsSync()) {
      proxyFile.parent.createSync(recursive: true);
    }
    final duration = await getVideoDuration(originalPath);
    final proxyCmd =
        '-y -i "$originalPath" -vf "scale=-2:480" -pix_fmt yuv420p '
        '-c:v libx264 -preset ultrafast -crf 28 -movflags +faststart "$proxyPath"';

    LoggerService.d("Executing FFmpeg: $proxyCmd");

     final proxySession = await FFmpegKit.executeAsync(
      proxyCmd,
      (session) async {
        final state = await session.getState();
        final returnCode = await session.getReturnCode();
        final failStackTrace = await session.getFailStackTrace();

        if (ReturnCode.isSuccess(returnCode)) {
          LoggerService.i("FFmpeg Success!"); 
          completer.complete(true) ; 
        } else {
         completer.complete(false); 
          final output = await session.getOutput();
          LoggerService.d("FFmpeg Failed with state $state and RC $returnCode");
          LoggerService.d("FFmpeg Output: $output");
          if (failStackTrace != null) log("FFmpeg StackTrace: $failStackTrace");
        }
      },
      (logMessage) {
        // log("FFmpeg Log: ${logMessage.getMessage()}"); 
      },
      (statistics) {
        final timeMs = statistics.getTime();
        final timeSec = timeMs / 1000;
        final progress = (timeSec / duration).clamp(0.0, 1.0);
        onProgress(progress);
      },
    ); 

    // final session = await FFmpegKit.execute(proxyCmd);
    final proxyReturnCode = await proxySession.getReturnCode();
    // if (ReturnCode.isSuccess(proxyReturnCode)) {
    //   log("FFmpeg Success! Proxy created at: $proxyPath");
    //   return proxyPath;
    // } else {
    //   return null;
    // } 
    return completer.future ;
  }

  Future<double> getVideoDuration(String path) async {
    final session = await FFprobeKit.getMediaInformation(path);
    final info = session.getMediaInformation();

    final duration = info?.getDuration();
    return double.parse(duration ?? "0");
  }
}
