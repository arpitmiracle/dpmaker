import 'package:dpmaker/Constants/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrameImageController extends GetxController with GetTickerProviderStateMixin {
  RxDouble currentRotation = 0.0.obs;
  RxDouble imageRotation = 0.0.obs;
  RxDouble imageResize = 1.0.obs;
  RxBool imageFlipVertical = false.obs;
  RxBool imageFlipHorizontal = false.obs;
  late TabController tabController;
  late TabController frameTabController;
  RxString selectedFrame = (framesList.first['frames'].first.toString()).obs;

  @override
  void onInit() {
    tabController = TabController(length: 5, vsync: this);
    frameTabController = TabController(length: framesList.length, vsync: this);
    super.onInit();
  }
}