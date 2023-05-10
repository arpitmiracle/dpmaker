import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Utils/AdsHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticker_view/stickerview.dart';

class FrameImageController extends GetxController with GetTickerProviderStateMixin {
  RxDouble currentRotation = 0.0.obs;
  RxDouble imageRotation = 0.0.obs;
  RxDouble imageResize = 1.0.obs;
  RxBool imageFlipVertical = false.obs;
  RxBool imageFlipHorizontal = false.obs;
  late TabController tabController;
  late TabController frameTabController;
  late TabController stickerTabController;
  RxString selectedFrame = (framesList.first['frames'][2].toString()).obs;
  RxString selectedSticker = "".obs;
  Rx<ColorFilter?> selectedColorFilter = (null as ColorFilter?).obs;
  List<Sticker> stickerList = <Sticker>[];
  AdsHelper adsHelper = AdsHelper();


  @override
  void onInit() {
    AdsHelper.loadInterstitialAd();
    adsHelper.loadBannerAd();
    tabController = TabController(length: 5, vsync: this,initialIndex: 2);
    frameTabController = TabController(length: framesList.length, vsync: this);
    stickerTabController = TabController(length: stickersList.length, vsync: this);
    super.onInit();
  }
}