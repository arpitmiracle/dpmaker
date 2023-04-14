import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(text: "Flip"),
              SizedBox(width: 15.w,),
              InkWell(
                child: Obx(() => Image.asset(ImagePath.ic_horizontal,width: 30,color: controller.imageFlipHorizontal.value ? CustomColors.primary : CustomColors.black)),
                onTap: () {
                  controller.imageFlipHorizontal.value = !controller.imageFlipHorizontal.value;
                },
              ),
              SizedBox(width: 30,),
              InkWell(
                child: Obx(() => Image.asset(ImagePath.ic_vertical,width: 30,color: controller.imageFlipVertical.value ? CustomColors.primary : CustomColors.black,)),
                onTap: () {
                  controller.imageFlipVertical.value = !controller.imageFlipVertical.value;
                },
              ),
              // IconButton(
              //   onPressed: () {
              //     controller.imageFlipHorizontal.value = !controller.imageFlipHorizontal.value;
              //   },
              //   icon: Icon(Icons.flip),
              // ),
              // IconButton(
              //   onPressed: () {
              //     controller.imageFlipVertical.value = !controller.imageFlipVertical.value;
              //   },
              //   icon: Icon(Icons.flip_to_front),
              // ),
            ],
          ),
          Row(
            children: [
              CustomText(text: "Rotate"),
              Expanded(
                child: Obx(() => Slider(
                  min: 0,
                  max: 8,
                  value: controller.imageRotation.value,
                  onChanged: (value) {
                    controller.imageRotation.value = value;
                  },
                  activeColor: CustomColors.primary,
                  inactiveColor: CustomColors.primary.withOpacity(0.5),
                )),
              ),
            ],
          ),
          Row(
            children: [
              CustomText(text: "Resize"),
              Expanded(
                child: Obx(() => Slider(
                  min: 0,
                  max: 1,
                  value: controller.imageResize.value,
                  onChanged: (value) {
                    controller.imageResize.value = value;
                  },
                  activeColor: CustomColors.primary,
                  inactiveColor: CustomColors.primary.withOpacity(0.5),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
