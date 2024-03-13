import 'dart:io';

import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
import 'package:dpmaker/Utils/AdsHelper.dart';
import 'package:dpmaker/Utils/DialogHelper.dart';
import 'package:dpmaker/Utils/PermissionUtils.dart';
import 'package:dpmaker/Utils/Utils.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class MyAlbumScreen extends StatefulWidget {
  MyAlbumScreen({Key? key}) : super(key: key);

  @override
  State<MyAlbumScreen> createState() => _MyAlbumScreenState();
}

class _MyAlbumScreenState extends State<MyAlbumScreen> {
  AdsHelper adsHelper = AdsHelper();
  List<File> allMedia = Utils.fetchAllMedia();
  @override
  void initState() {
    checkPermission();
    AdsHelper.loadInterstitialAd();
    adsHelper.loadBannerAd();
    super.initState();
  }

  checkPermission()async{
    if(await PermissionUtils.checkStoragePermissionGranted()){
      setState(() {
        allMedia = Utils.fetchAllMedia();
      });
    }
  }


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
              child: Stack(
                children: [
                  InkWell(
                    child: Image.asset(ImagePath.ic_back),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  Center(
                    child: CustomTitle(
                      title: "My Album",
                      fontColor: CustomColors.primary,
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 1,color: CustomColors.primary,),
            Expanded(
              child: allMedia.isEmpty ? Center(
                child: CustomTitle(
                  title: "No images found!",
                  fontColor: CustomColors.primary,
                ),
              ) :
              ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: allMedia.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.file(allMedia[index],),
                    title: Text(allMedia[index].path.split("/").last),
                    contentPadding: EdgeInsets.zero,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () {
                          Share.shareXFiles([XFile(allMedia[index].path)]);
                        }, icon: Image.asset(ImagePath.ic_share,height: 40,),),
                        IconButton(onPressed: () {
                          DialogHelper.AdConfirmationDialog(context, title: "Delete image", desc: "Are you sure you want to delete this image?",yes: "Yes", onYes: () async {
                            await Utils.deleteFile(allMedia[index]);
                            setState(() {
                              allMedia = Utils.fetchAllMedia();
                            });
                          },);
                        }, icon: Image.asset(ImagePath.ic_delete,height: 40,)),
                      ],
                    ),
                  );
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          MultiImageProvider multiImageProvider = MultiImageProvider(List.generate(allMedia.length,(index) => FileImage(allMedia[index]),));

                          showImageViewerPager(context, multiImageProvider, onPageChanged: (page) {
                            print("page changed to $page");
                          },swipeDismissible: true,doubleTapZoomable: true, onViewerDismissed: (page) {
                            print("dismissed while on page $page");
                          });

                        },
                        child: Image.file(allMedia[index],height: 45.w,width: 45.w,),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: () {
                              DialogHelper.AdConfirmationDialog(context, title: "Delete image", desc: "Are you sure you want to delete this image?",yes: "Yes", onYes: () async {
                                await Utils.deleteFile(allMedia[index]);
                                setState(() {
                                  allMedia = Utils.fetchAllMedia();
                                });
                              },);
                            }, icon: Image.asset(ImagePath.ic_delete,height: 40,)),
                            IconButton(onPressed: () {
                              Share.shareXFiles([XFile(allMedia[index].path)]);
                            }, icon: Image.asset(ImagePath.ic_share,height: 40,),),
                          ],
                        ),
                      ),
                    ],
                  );
                },)
              // GridView.builder(
              //   padding: EdgeInsets.all(10),
              //   itemCount: allMedia.length,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 10,
              //     mainAxisSpacing: 10,
              //   ),
              //   itemBuilder: (BuildContext context, int index) {
              //     return Stack(
              //       children: [
              //         InkWell(
              //           onTap: () {
              //             MultiImageProvider multiImageProvider = MultiImageProvider(List.generate(allMedia.length,(index) => FileImage(allMedia[index]),));
              //
              //             showImageViewerPager(context, multiImageProvider, onPageChanged: (page) {
              //               print("page changed to $page");
              //             },swipeDismissible: true,doubleTapZoomable: true, onViewerDismissed: (page) {
              //               print("dismissed while on page $page");
              //             });
              //
              //           },
              //           child: Image.file(allMedia[index],height: 45.w,width: 45.w,),
              //         ),
              //         Align(
              //           alignment: Alignment.bottomRight,
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               IconButton(onPressed: () {
              //                 DialogHelper.AdConfirmationDialog(context, title: "Delete image", desc: "Are you sure you want to delete this image?",yes: "Yes", onYes: () async {
              //                   await Utils.deleteFile(allMedia[index]);
              //                   setState(() {
              //                     allMedia = Utils.fetchAllMedia();
              //                   });
              //                 },);
              //               }, icon: Image.asset(ImagePath.ic_delete,height: 40,)),
              //               IconButton(onPressed: () {
              //                 Share.shareXFiles([XFile(allMedia[index].path)]);
              //               }, icon: Image.asset(ImagePath.ic_share,height: 40,),),
              //             ],
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // ),
            ),
          ],
        )
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: adsHelper.showBannerAd(),
      ),
    );
  }
}
