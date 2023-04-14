import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:crop_image/crop_image.dart';
import 'package:custom_elements/custom_elements.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'Frames/FlipRotate.dart';
import 'Frames/FrameFilters.dart';
import 'Frames/FrameStickers.dart';
import 'Frames/frameSelection.dart';

class FrameImageScreen extends StatelessWidget {
  var imageBytes;
  FrameImageScreen({required this.imageBytes});
  FrameImageController controller = Get.put(FrameImageController());
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePath.bg_edit_image2),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  height: 70,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Image.asset(ImagePath.ic_back),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      InkWell(
                        child: Image.asset(ImagePath.ic_download),
                        onTap: () {
                          saveImage();
                        },
                      ),
                    ],
                  ),
                ),
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
                                      scaleX: controller.imageFlipHorizontal.value ? -1 : 1,
                                      scaleY: controller.imageFlipVertical.value ? -1 : 1,
                                      child: Obx(() => controller.selectedColorFilter.value != null ? ClipRRect(
                                        borderRadius: BorderRadius.circular(200),
                                        child: ColorFiltered(
                                          colorFilter: controller.selectedColorFilter.value!,
                                          child: CircleAvatar(
                                            backgroundImage: MemoryImage(imageBytes,),
                                            radius: double.infinity,
                                          ),
                                        ),
                                      ) : CircleAvatar(
                                        backgroundImage: MemoryImage(imageBytes,),
                                        radius: double.infinity,
                                      ),)
                                  ),
                                ),)
                            ),
                            if(controller.selectedFrame.value.isNotEmpty) Transform.rotate(
                              angle: controller.currentRotation.value,
                              child: Image.asset(controller.selectedFrame.value, fit: BoxFit.cover,),
                            ),
                            if(controller.selectedSticker.value.isNotEmpty) Center(child: Image.asset(controller.selectedSticker.value,height: 30,)),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.bg_edit_image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  GetBuilder<FrameImageController>(builder: (c) {
                    return controller.tabController.index == 2 ? Obx(() => Slider(
                      min: 0,
                      max: 8,
                      value: controller.currentRotation.value,
                      onChanged: (value) {
                        controller.currentRotation.value = value;
                      },
                      activeColor: CustomColors.primary,
                      inactiveColor: CustomColors.primary.withOpacity(0.5),
                    )) : Container();
                  },),
                  Expanded(child: TabBarView(
                    controller: controller.tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      FrameFilter(),
                      FlipRotate(),
                      FrameSelection(),
                      FrameStickers(),
                      Container(),
                    ],
                  )),
                  Divider(height: 1,color: CustomColors.primary,),
                  GetBuilder<FrameImageController>(builder: (controller) {
                    return TabBar(
                      controller: controller.tabController,
                      tabs: [
                        Tab(
                          child: Image.asset(ImagePath.ic_filters,color: controller.tabController.index == 0 ? CustomColors.primary : CustomColors.black,),
                        ),
                        Tab(
                          child: Image.asset(ImagePath.ic_rotate_flip,color: controller.tabController.index == 1 ? CustomColors.primary : CustomColors.black,),
                        ),
                        Tab(
                          child: Image.asset(ImagePath.ic_frames,color: controller.tabController.index == 2 ? CustomColors.primary : CustomColors.black,),
                        ),
                        Tab(
                          child: Image.asset(ImagePath.ic_emoji,color: controller.tabController.index == 3 ? CustomColors.primary : CustomColors.black,),
                        ),
                        Tab(
                          child: Image.asset(ImagePath.ic_text,color: controller.tabController.index == 4 ? CustomColors.primary : CustomColors.black,),
                        ),
                      ],
                      indicatorColor: CustomColors.primary,
                      onTap: (value) => controller.update(),
                    );
                  },)
                ],
              ),
            ),
          )
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
