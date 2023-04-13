import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:crop_image/crop_image.dart';
import 'package:custom_elements/custom_elements.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'Frames/FlipRotate.dart';
import 'Frames/frameSelection.dart';

class FrameImageScreen extends StatelessWidget {
  var imageBytes;
  FrameImageScreen({required this.imageBytes});
  FrameImageController controller = Get.put(FrameImageController());
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frame image"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text("Save as png"),value: 1),
                PopupMenuItem(child: Text("Save as transparent png"),value: 2),
              ];
            },
            icon: Icon(Icons.save_alt),
            onSelected: (value) {
              saveImage();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.grey.withOpacity(0.1),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Screenshot(
              controller: screenshotController,
              child: Center(
                child: Container(
                  width: 90.w,
                  height: 90.w,
                  child: Obx(() => Stack(
                    children: [
                      Transform.rotate(
                        angle: controller.imageRotation.value,
                        child: Obx(() => Transform.scale(
                          scale: controller.imageResize.value,
                          child: Transform.scale(
                            scaleX: controller.imageFlipHorizontal.value ? 1 : -1,
                            scaleY: controller.imageFlipVertical.value ? -1 : 1,
                            child: CircleAvatar(
                              backgroundImage: MemoryImage(imageBytes,),
                              radius: double.infinity,
                            ),
                          ),
                        ),)
                      ),
                      Transform.rotate(
                        angle: controller.currentRotation.value,
                        child: Image.asset(controller.selectedFrame.value, fit: BoxFit.cover,),
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ),
          Obx(() => Slider(
            min: 0,
            max: 8,
            value: controller.currentRotation.value,
            onChanged: (value) {
              controller.currentRotation.value = value;
            },
          )),

          Expanded(child: TabBarView(
            controller: controller.tabController,
            children: [
              FrameSelection(),
              Container(),
              FlipRotate(),
              Container(),
              Container(),
            ],
          )),
          TabBar(
            controller: controller.tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.filter_frames,color: Colors.black,),
              ),
              Tab(
                icon: Icon(Icons.circle,color: Colors.black),
              ),
              Tab(
                icon: Icon(Icons.photo,color: Colors.black),
              ),
              Tab(
                icon: Icon(Icons.person,color: Colors.black),
              ),
              Tab(
                icon: Icon(Icons.text_fields,color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  saveImage(){
    screenshotController
        .capture(delay: Duration(milliseconds: 10))
        .then((capturedImage) async {
      //Save single image file
      DocumentFileSavePlus().saveFile(capturedImage!, "DP_${DateTime.now()}.png", "image/png");
    }).catchError((onError) {
      print(onError);
    });
  }
}
