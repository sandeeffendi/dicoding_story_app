import 'dart:typed_data';
import 'dart:ui' as ui;

class ImageCompressionService {
  static const int maxSizeInBytes = 1024 * 1024; // 1 MB

  Future<Uint8List> compressUnder1MB(Uint8List bytes) async {
    // Decode image
    ui.Image image = await _decodeImage(bytes);

    int targetWidth = image.width;
    int targetHeight = image.height;

    Uint8List result = bytes;

    // Loop resize sampai < 1MB
    while (result.lengthInBytes > maxSizeInBytes || targetWidth > 300) {
      targetWidth = (targetWidth * 0.8).round();
      targetHeight = (targetHeight * 0.8).round();

      final resized = await _resizeImage(image, targetWidth, targetHeight);

      result = resized;
      image = await _decodeImage(resized);
    }

    return result;
  }

  // Decode bytes → ui.Image
  Future<ui.Image> _decodeImage(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  // Resize & encode ulang ke JPEG
  Future<Uint8List> _resizeImage(ui.Image image, int width, int height) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    final paint = ui.Paint()..filterQuality = ui.FilterQuality.high;

    canvas.drawImageRect(
      image,
      ui.Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      paint,
    );

    final picture = recorder.endRecording();
    final resizedImage = await picture.toImage(width, height);

    final byteData = await resizedImage.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return byteData!.buffer.asUint8List();
  }
}
