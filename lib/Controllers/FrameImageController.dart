import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrameImageController extends GetxController with GetTickerProviderStateMixin {
  RxDouble currentRotation = 0.0.obs;
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }
}