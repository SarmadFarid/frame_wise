import 'package:video_thumbnail/video_thumbnail.dart';

class VideoServices {
  static Future<String?> generateThumbnail(
    String videoPath,
    String savePath,
  ) async {
    final thumb = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      quality: 100,
      thumbnailPath: savePath,
    );

    return thumb;
  }
}
