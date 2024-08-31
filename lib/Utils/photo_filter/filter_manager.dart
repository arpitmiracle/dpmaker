import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'package:dpmaker/Utils/photo_filter/photo_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class FilterManager {
  static Future<File> applyFilter(ApplyFilterParams applyFilterParams) async {
    final img.Image? image = await ImageProcessor.loadImage(applyFilterParams.rawFile);

    if (image == null) throw Exception("Failed to decode image");

    // Apply the color filter
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final img.Pixel pixel = image.getPixel(x, y);

        final num alpha = pixel.a;
        final num red = pixel.r;
        final num green = pixel.g;
        final num blue = pixel.b;

        final newColor = _multiplyByColorFilter([red, green, blue, alpha], applyFilterParams.colorMatrix);

        final color = img.ColorRgba8(newColor[0], newColor[1], newColor[2], newColor[3]);
        image.setPixel(x, y, color);
      }
    }

    if (applyFilterParams.brightness != midBrightness || applyFilterParams.contrast != midContrast || applyFilterParams.saturation != midSaturation) {
      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          final img.Pixel pixel = image.getPixel(x, y);

          final num alpha = pixel.a;
          final num red = pixel.r;
          final num green = pixel.g;
          final num blue = pixel.b;

          final newColor = _multiplyByColorFilter([red, green, blue, alpha], applyFilterParams.defaultMatrix);

          final color = img.ColorRgba8(newColor[0], newColor[1], newColor[2], newColor[3]);
          image.setPixel(x, y, color);
        }
      }
    }

    return await ImageProcessor.saveImage(image, applyFilterParams.shouldCompress, applyFilterParams.compressQuality);
  }

  static List<int> _multiplyByColorFilter(List<num> color, List<double> matrix) {
    final r = (color[0] * matrix[0] + color[1] * matrix[1] + color[2] * matrix[2] + color[3] * matrix[3] + matrix[4]).clamp(0, 255).toInt();
    final g = (color[0] * matrix[5] + color[1] * matrix[6] + color[2] * matrix[7] + color[3] * matrix[8] + matrix[9]).clamp(0, 255).toInt();
    final b = (color[0] * matrix[10] + color[1] * matrix[11] + color[2] * matrix[12] + color[3] * matrix[13] + matrix[14]).clamp(0, 255).toInt();
    final a = (color[0] * matrix[15] + color[1] * matrix[16] + color[2] * matrix[17] + color[3] * matrix[18] + matrix[19]).clamp(0, 255).toInt();

    return [r, g, b, a];
  }
}

void applyFilter(ApplyFilterParams applyFilterParams) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(applyFilterParams.rootIsolateToken);
  File filteredImageFile = await FilterManager.applyFilter(applyFilterParams);
  applyFilterParams.sendPort.send(filteredImageFile);
}

@immutable
class ApplyFilterParams {
  final File rawFile;
  final List<double> colorMatrix;
  final double brightness;
  final double contrast;
  final double saturation;
  final List<double> defaultMatrix;
  final SendPort sendPort;
  final RootIsolateToken rootIsolateToken;
  final bool shouldCompress;
  final int? compressQuality;

  ApplyFilterParams(
      {required this.shouldCompress,
        this.compressQuality,
        required this.rootIsolateToken,
        required this.sendPort,
        required this.rawFile,
        required this.colorMatrix,
        required this.brightness,
        required this.contrast,
        required this.saturation,
        required this.defaultMatrix});
}

void applyFilterWeb(ApplyFilterParams applyFilterParams) async {
  File filteredImageFile = await FilterManager.applyFilter(applyFilterParams);
  applyFilterParams.sendPort.send(filteredImageFile);
}


class ImageProcessor {
  static Future<img.Image?> loadImage(File file) async {
    final List<int> bytes = await file.readAsBytes();
    return img.decodeImage(Uint8List.fromList(bytes));
  }

  static Future<File> saveImage(img.Image image, bool shouldCompress, int? compressQuality) async
  {
    image = shouldCompress ? compressImage(image,compressQuality ?? 75) : image;

    final directory = await getTemporaryDirectory();
    final path = "${directory.path}/${generateRandomString()}.png";
    final File file = File(path);
    file.writeAsBytesSync(img.encodePng(image));
    return file;
  }

  static img.Image compressImage(img.Image originalImage, int quality) {
    Uint8List? compressedBytes = img.encodeJpg(originalImage, quality: quality);
    return img.decodeImage(compressedBytes)!;
  }
}

String generateRandomString() {
  final random = Random();
  const availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final randomString = List.generate(4,
          (index) => availableChars[random.nextInt(availableChars.length)]).join();

  return randomString;
}