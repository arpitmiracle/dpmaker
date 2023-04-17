import 'dart:io';

import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
import 'package:dpmaker/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlbumScreen extends StatelessWidget {
  MyAlbumScreen({Key? key}) : super(key: key);
  List<File> allMedia = Utils.fetchAllMedia();

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
                ),
              ) : GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: allMedia.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Image.file(allMedia[index]),
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
