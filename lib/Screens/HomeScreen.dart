import 'dart:io';
import 'package:flutter/material.dart';
import 'package:custom_elements/custom_elements.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dpmaker/Constants/IconPath.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
import 'package:dpmaker/Localization/AppStrings.dart';
import 'package:dpmaker/Route/Routes.dart';
import 'package:dpmaker/Constants/DialogSelectType.dart';
import 'package:dpmaker/Utils/Extentions.dart';
import 'package:dpmaker/Utils/Utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => backPressed(context),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.cut9_photos.toLocalized(context),
          iconSize: 0,
        ),
        backgroundColor: CustomColors.scaffoldBgColor,
        body: Container(
          height: 100.h,
          width: 100.w,
          alignment: Alignment.center,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: CustomColors.cardBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 60.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Share.share(AppStrings.share_app_description.toLocalized(context));
                          },
                          child: CircleAvatar(
                            radius: 8.w,
                            backgroundColor: CustomColors.primary,
                            child: Center(
                              child: Icon(IconPath.share,color: CustomColors.scaffoldBgColor,size: 8.w),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {

                          },
                          child: CircleAvatar(
                            radius: 8.w,
                            backgroundColor: CustomColors.primary,
                            child: Center(
                              child: Icon(IconPath.star_rate,color: CustomColors.scaffoldBgColor,size: 8.w),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 3.h,),
              ],
            )),
      ),
    );
  }

 void onSelected(BuildContext context,){
    showSelectTypeDialog(context,onTypeTap: (val) async {
      Navigator.pop(context);
      CustomProgressBar progressBar = CustomProgressBar();
      progressBar.show(context);

      final XFile? image = await _picker.pickImage(source: val == 1 ? ImageSource.camera : ImageSource.gallery);
      progressBar.hide();

    },);

  }
}

class DashboardItem extends StatelessWidget {
  String imagepath;
  String title;
  double width;
  VoidCallback onTap;
  DashboardItem({Key? key,required this.imagepath,required this.title,required this.onTap,required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: CustomColors.cardBgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: width,
        child: Column(
          children: [
            Image.asset(imagepath,height: 12.w),
            SizedBox(height: 1.h,),
            CustomTitle(title: title,fontColor: CustomColors.primary),
          ],
        ),
      ),
    );
  }
}
