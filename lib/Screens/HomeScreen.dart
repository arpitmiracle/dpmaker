import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Screens/CropImageScreen.dart';
import 'package:dpmaker/Screens/SendNotificationScreen.dart';
import 'package:dpmaker/Utils/AdsHelper.dart';
import 'package:flutter/material.dart';
import 'package:custom_elements/custom_elements.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dpmaker/Constants/IconPath.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
import 'package:dpmaker/Localization/AppStrings.dart';
import 'package:dpmaker/Route/Routes.dart';
import 'package:dpmaker/Utils/Extentions.dart';
import 'package:dpmaker/Utils/Utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MyAlbumScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  AdsHelper adsHelper = AdsHelper();
  List<String> backgroundImages = [
    ImagePath.bg_home,
    ImagePath.ic_color,
    ImagePath.ic_download,
  ];
  int _currentIndex = Random().nextInt(2);
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % backgroundImages.length;
      });
    });
  }

  @override
  void initState() {
    registerAnalyticsEvent(name: EventType.homeScreen);
    AdsHelper.loadInterstitialAd();
    adsHelper.loadMediumNativeAd();
    adsHelper.loadBannerAd();
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: WillPopScope(
        onWillPop: () => backPressed(context),
        child: Scaffold(
          body: Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImages[_currentIndex]),
                  fit: BoxFit.cover,
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Container(
                        //   margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                        //   padding: EdgeInsets.all(10),
                        //   height: 255,
                        //   color: CustomColors.white,
                        //   child: adsHelper.showNativeMediumAd(),
                        // ),
                        adsHelper.showNativeMediumAd(),
                        if(InDevelopment) ElevatedButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Sendnotificationscreen(),));
                        }, child: Text("Send Notification")),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                await AdsHelper.showInterstitialAd();
                                Share.share(AppStrings.share_app_description.toLocalized(context));
                              },
                              child: Image.asset(ImagePath.ic_share,height: 60,),
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: () async {
                                await AdsHelper.showInterstitialAd();
                                launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.photos.dpcreator"),mode: LaunchMode.externalApplication);
                              },
                              child: Image.asset(ImagePath.ic_star,height: 60,),
                            ),
                          ],
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
                        Color(0xff796db0),
                        Color(0xffbc9cd4),
                        Color(0xffdfc4cf),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          await AdsHelper.showInterstitialAd();
                          onSelected(context,2);
                        },
                        child: Image.asset(ImagePath.ic_gallery,height: 50,),
                      ),
                      SizedBox(width: 10.w,),
                      InkWell(
                        onTap: () async {
                          await AdsHelper.showInterstitialAd();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyAlbumScreen(),));
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
              await AdsHelper.showInterstitialAd();
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
          bottomNavigationBar: Container(
            // height: 50,
            child: adsHelper.showBannerAd(),
          ),
        ),
      ),
    );
  }

  onSelected(BuildContext context, val)async{
    CustomProgressBar progressBar = CustomProgressBar();
    progressBar.show(context);
    try{
      final XFile? image = await _picker.pickImage(source: val == 1 ? ImageSource.camera : ImageSource.gallery);
      progressBar.hide();
      if(image != null){
        registerAnalyticsEvent(name: EventType.cropImageScreen);
        Navigator.push(context, MaterialPageRoute(builder: (context) => CropImageScreen(imagePath: image.path),));
      }
    } catch (e) {}
    progressBar.hide();
  }
}
