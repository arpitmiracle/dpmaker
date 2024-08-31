import 'dart:math';
import 'package:custom_elements/custom_elements.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
import 'package:dpmaker/Screens/MyAlbumScreen.dart';
import 'package:dpmaker/Utils/AdsHelper.dart';
import 'package:dpmaker/Utils/DialogHelper.dart';
import 'package:dpmaker/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sticker_view/draggable_stickers.dart';
import 'package:sticker_view/stickerview.dart';
import 'Frames/FlipRotate.dart';
import 'Frames/FrameFilters.dart';
import 'Frames/FrameStickers.dart';
import 'Frames/FrameText.dart';
import 'Frames/frameSelection.dart';

class FrameImageScreen extends StatelessWidget {
  var imageBytes;
  FrameImageScreen({required this.imageBytes});
  FrameImageController controller = Get.put(FrameImageController());
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DialogHelper.AdConfirmationDialog(context, title: "Discard changes", desc: "Are you sure you want to go back? all your changes will be removed, go back.",yes: "Yes", onYes: () async {
          Get.back();
        },);
        return false;
      },
      child: Scaffold(
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
                          onTap: () async {
                            await AdsHelper.showInterstitialAd(ignoreCount: true);
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
                              Center(
                                child: GetBuilder<FrameImageController>(
                                  builder: (controller) {
                                    return controller.stickerList.isEmpty ? Container() : DraggableStickers(
                                      stickerList: controller.stickerList,
                                      onEdit: (stkr) async {
                                        AdsHelper.showInterstitialAd();
                                        if(stkr.isText == true){
                                          TextData? data = await Navigator.push(context, MaterialPageRoute(builder: (context) => FrameText(stickerText: stkr.child as TextWidth?),));
                                          if(data != null) {
                                            controller.stickerList[controller.stickerList.indexWhere((element) => element.id == stkr.id)] = Sticker(id: stkr.id,isText: true,child: TextWidth(selectedFrame: data.frame,text: data.text,style: TextStyle(color: data.color,fontFamily: data.font)),);
                                            controller.update();
                                          }
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
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
                            child: Image.asset(ImagePath.ic_filters,color: controller.tabController.index == 0 ? CustomColors.primary : CustomColors.black,width: 35,height: 35,),
                          ),
                          Tab(
                            child: Image.asset(ImagePath.ic_rotate_flip2,color: controller.tabController.index == 1 ? CustomColors.primary : CustomColors.black,width: 30,height: 30,),
                          ),
                          Tab(
                            child: Image.asset(ImagePath.ic_frames,color: controller.tabController.index == 2 ? CustomColors.primary : CustomColors.black,width: 35,height: 35,),
                          ),
                          Tab(
                            child: Image.asset(ImagePath.ic_emoji,color: controller.tabController.index == 3 ? CustomColors.primary : CustomColors.black,width: 35,height: 35,),
                          ),
                          Tab(
                            child: Image.asset(ImagePath.ic_text,color: controller.tabController.index == 4 ? CustomColors.primary : CustomColors.black,width: 35,height: 35,),
                          ),
                        ],
                        indicatorColor: CustomColors.primary,
                        onTap: (value) async {
                          AdsHelper.showInterstitialAd();
                          if(value == 4){
                            controller.tabController.animateTo(controller.tabController.previousIndex);
                            TextData? data = await Navigator.push(context, MaterialPageRoute(builder: (context) => FrameText(),));
                            if(data != null) {
                              controller.stickerList.add(Sticker(id: "Text${DateTime.now().hashCode}",isText: true,child: TextWidth(selectedFrame: data.frame,text: data.text,style: TextStyle(color: data.color,fontFamily: data.font)),));
                              controller.update();
                            }
                          }
                          controller.update();
                        },
                      );
                    },)
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          // height: 50,
          child: controller.adsHelper.showBannerAd(),
        ),
      ),
    );
  }

  saveImage(){
    screenshotController
        .capture(delay: Duration(milliseconds: 10))
        .then((capturedImage) async {
      //Save single image file
      await DocumentFileSavePlus().saveFile(capturedImage!, "DP_Creator${DateTime.now()}.png", "image/png");
      Utils.showToast("Profile Pic saved successfully!");
      Get.off(() => MyAlbumScreen());
    }).catchError((onError) {
      print(onError);
    });
  }
}
