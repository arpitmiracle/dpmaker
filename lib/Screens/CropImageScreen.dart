import 'dart:io';
import 'dart:ui' as ui;
import 'package:crop_image/crop_image.dart';
import 'package:dpmaker/Screens/FrameImageScreen.dart';
import 'package:flutter/material.dart';

class CropImageScreen extends StatelessWidget {
  String imagePath;
  CropImageScreen({required this.imagePath});

  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop image"),
      ),
      body: Center(
        child: CropImage(
          controller: controller,
          image: Image.file(File(imagePath)),
          paddingSize: 25.0,
          alwaysMove: true,
        ),
      ),
      bottomNavigationBar: _buildButtons(context),
    );
  }

  Widget _buildButtons(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          controller.rotation = CropRotation.up;
          controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
          controller.aspectRatio = 1.0;
        },
      ),
      IconButton(
        icon: const Icon(Icons.rotate_90_degrees_ccw_outlined),
        onPressed: _rotateLeft,
      ),
      IconButton(
        icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
        onPressed: _rotateRight,
      ),
      TextButton(
        onPressed: () async {
          ui.Image img = await controller.croppedBitmap();
          var byteData = (await img.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FrameImageScreen(imageBytes: byteData),));
        },
        child: const Text('Done'),
      ),
    ],
  );

  Future<void> _rotateLeft() async => controller.rotateLeft();

  Future<void> _rotateRight() async => controller.rotateRight();
}
