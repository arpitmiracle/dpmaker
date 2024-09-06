import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
import 'package:dpmaker/Utils/AdsHelper.dart';
import 'package:dpmaker/Utils/DialogHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticker_view/stickerview.dart';

class FrameStickers extends StatelessWidget {
  FrameImageController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TabBar(
            controller: controller.stickerTabController,
            tabs: List.generate(controller.stickerTabController.length, (index) => Tab(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 15),
                decoration: BoxDecoration(
                  color: CustomColors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(stickersList[index]['category'].toString(),style: TextStyle(color: Colors.white)),
              ),
            )),
            isScrollable: true,
            indicatorColor: CustomColors.primary,
          ),
          Divider(height: 1,color: CustomColors.primary,),
          Expanded(child: TabBarView(
            controller: controller.stickerTabController,
            children:  List.generate(controller.stickerTabController.length, (i) => Container(
              child: GridView.builder(
                itemCount: stickersList[i]['stickers'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      // if(index > 2){
                      //   DialogHelper.AdConfirmationDialog(context,title: "Want to use sticker?",desc: "To use this sticker, watch ad first. It's worth it!",onYes: () async {
                      //     await AdsHelper.loadAndShowInterstitialPremium(context,onDone: () {
                      //       controller.stickerList.add(Sticker(id: "Sticker$index${DateTime.now().hashCode}",child: Container(height: 40,width: 40,child: Center(child: Image.asset(stickersList[i]['stickers'][index],fit: BoxFit.cover,))),));
                      //       controller.update();
                      //     },);
                      //   },);
                      // } else {
                        registerAnalyticsEvent(name: "sticker_${stickersList[i]['stickers'][index].toString().replaceAll("assets/stickers/", "").replaceAll(".png", "").replaceAll("/", "_")}");
                        controller.stickerList.add(Sticker(id: "Sticker$index${DateTime.now().hashCode}",child: Container(height: 40,width: 40,child: Center(child: Image.asset(stickersList[i]['stickers'][index],fit: BoxFit.cover,))),));
                        controller.update();
                      // }
                    },
                    child: Stack(
                      children: [
                        CachedNetworkImage(imageUrl: stickersList[i]['stickers'][index]),
                        // if(index > 2) Center(child: Icon(Icons.lock,),),
                      ],
                    ),
                  );
                },
              ),
            )),
          )),
        ],
      ),
    );
  }
}
