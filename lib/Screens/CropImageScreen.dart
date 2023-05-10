import 'dart:io';
import 'dart:ui' as ui;
import 'package:crop_image/crop_image.dart';
import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
import 'package:dpmaker/Screens/FrameImageScreen.dart';
import 'package:dpmaker/Utils/AdsHelper.dart';
import 'package:dpmaker/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropImageScreen extends StatefulWidget {
  String imagePath;
  CropImageScreen({required this.imagePath});

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  AdsHelper adsHelper = AdsHelper();

  @override
  void initState() {
    AdsHelper.loadInterstitialAd();
    adsHelper.loadBannerAd();
    super.initState();
  }

  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.bg_edit_image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
                    child: Image.asset(ImagePath.ic_done),
                    onTap: () async {
                      await AdsHelper.showInterstitialAd();
                      CustomProgressBar progressBar = CustomProgressBar();
                      progressBar.show(context);
                      try{
                        ui.Image img = await controller.croppedBitmap();
                        var byteData = (await img.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
                        Get.off(() => FrameImageScreen(imageBytes: byteData));
                      } catch (e){} finally {
                        progressBar.hide();
                      }

                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: CropImage(
                controller: controller,
                image: Image.file(File(widget.imagePath)),
                paddingSize: 25.0,
                alwaysMove: true,
              ),
            ),
            _buildButtons(context),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: adsHelper.showBannerAd(),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) => Container(
    height: 60,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xff796db0),
          Color(0xffbc9cd4),
          Color(0xffdfc4cf),
        ],
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.close,color: CustomColors.white,),
          onPressed: () {
            controller.rotation = CropRotation.up;
            controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
            controller.aspectRatio = 1.0;
          },
        ),
        InkWell(
          child: Image.asset(ImagePath.ic_rotate_left,height: 30,),
          onTap: _rotateLeft,
        ),
        InkWell(
          child: Image.asset(ImagePath.ic_rotate_right,height: 30,),
          onTap: _rotateRight,
        ),
      ],
    ),
  );

  Future<void> _rotateLeft() async => controller.rotateLeft();

  Future<void> _rotateRight() async => controller.rotateRight();
}
