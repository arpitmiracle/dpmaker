import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:crop_image/crop_image.dart';
import 'package:custom_elements/custom_elements.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class FrameImageScreen extends StatelessWidget {
  Uint8List imageBytes;
  FrameImageScreen({required this.imageBytes});
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frame image"),
        actions: [
          IconButton(onPressed: () {
            screenshotController
                .capture(delay: Duration(milliseconds: 10))
                .then((capturedImage) async {
              //Save single image file
              DocumentFileSavePlus().saveFile(capturedImage!, "DP_${DateTime.now()}.png", "image/png");
            }).catchError((onError) {
              print(onError);
            });
          }, icon: Icon(Icons.save_alt)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Center(
              child: Container(
                width: 90.w,
                height: 90.w,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: MemoryImage(imageBytes,),
                      radius: double.infinity,
                    ),
                    Image.asset("assets/frames/Flowers/border_flower_12.png", fit: BoxFit.cover,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
