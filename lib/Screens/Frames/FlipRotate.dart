import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlipRotate extends StatelessWidget {
  FlipRotate({Key? key}) : super(key: key);
  FrameImageController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(() => Slider(
            min: 0,
            max: 8,
            value: controller.imageRotation.value,
            onChanged: (value) {
              controller.imageRotation.value = value;
            },
          )),
          Obx(() => Slider(
            min: 0,
            max: 1,
            value: controller.imageResize.value,
            onChanged: (value) {
              controller.imageResize.value = value;
            },
          )),
        ],
      ),
    );
  }
}
