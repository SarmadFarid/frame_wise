import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:frame_wise/app/services/video_services.dart';

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
  FrameExtractorService._();
  static FrameExtractorService instance = FrameExtractorService._();

  VideoServices videoService = VideoServices.instance;

  Future<bool> extractVideoFrames(
    String videoPath,
    String frameDirPath,
    Function(double progress) onProgress,
  ) async {
    final duration = await videoService.getVideoDuration(videoPath);
    final completer = Completer<bool>(); 
    final command =
        '-i "$videoPath" -vf "fps=2,scale=160:-1:flags=lanczos" -q:v 3 "$frameDirPath/frame_%04d.jpg"';

    final session = await FFmpegKit.executeAsync(
      command,
      (session) async {
        final returnCode = await session.getReturnCode(); 
        if(ReturnCode.isSuccess(returnCode)) {
          completer.complete(true); 
        } else {
          completer.complete(false); 
        }
        
      },
      (log) {},
      (statistics) {
        final timems = statistics.getTime();
        final timesec = timems / 1000;
        final progress = (timesec / duration).clamp(0.0, 1.0);
        onProgress(progress);
      },
    ); 
    // final session = await FFmpegKit.execute(command); 

    final returnCode = await session.getReturnCode();
    // if (ReturnCode.isSuccess(returnCode)) {
    //   log("Frames successfully extracted!");
    //   return true;
    // } else {
    //   log("Frame extraction failed!");
    //   return false;
    // } 
    return completer.future ; 
  }
}


