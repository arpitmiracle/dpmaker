import 'dart:io';
import 'package:dpmaker/Screens/CropImageScreen.dart';
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
        body: Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePath.bg_home),
                fit: BoxFit.cover,
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Share.share(AppStrings.share_app_description.toLocalized(context));
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage(ImagePath.ic_share),
                          radius: 30,
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse("https://github.com/"));
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage(ImagePath.ic_star),
                          radius: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3.h,),
              Container(
                height: 75,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffdf97a9),
                      Color(0xffe4a9ad),
                      Color(0xfff7e8c1),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        onSelected(context,2);
                      },
                      child: Image.asset(ImagePath.ic_gallery,height: 50,),
                    ),
                    SizedBox(width: 10.w,),
                    InkWell(
                      onTap: () {

                      },
                      child: Image.asset(ImagePath.ic_my_album,height: 50,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () async {
            onSelected(context,1);
          },
          child: Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.only(bottom: 15),
              child: Image.asset(ImagePath.ic_camera,),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  onSelected(BuildContext context, val)async{
    CustomProgressBar progressBar = CustomProgressBar();
    progressBar.show(context);
    final XFile? image = await _picker.pickImage(source: val == 1 ? ImageSource.camera : ImageSource.gallery);
    progressBar.hide();
    if(image != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => CropImageScreen(imagePath: image.path),));
    }
  }

}
