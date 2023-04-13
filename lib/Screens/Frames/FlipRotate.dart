import 'package:custom_elements/custom_elements.dart';
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
      padding: EdgeInsets.all(5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(text: "Flip"),
              SizedBox(width: 30,),
              IconButton(
                onPressed: () {
                  controller.imageFlipHorizontal.value = !controller.imageFlipHorizontal.value;
                },
                icon: Icon(Icons.flip),
              ),
              IconButton(
                onPressed: () {
                  controller.imageFlipVertical.value = !controller.imageFlipVertical.value;
                },
                icon: Icon(Icons.flip_to_front),
              ),
            ],
          ),
          Row(
            children: [
              CustomText(text: "Rotate"),
              Obx(() => Slider(
                min: 0,
                max: 8,
                value: controller.imageRotation.value,
                onChanged: (value) {
                  controller.imageRotation.value = value;
                },
              )),
            ],
          ),
          Row(
            children: [
              CustomText(text: "Resize"),
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
        ],
      ),
    );
  }
}
