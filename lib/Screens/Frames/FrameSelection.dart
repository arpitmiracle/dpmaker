import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
import 'package:dpmaker/Utils/AdsHelper.dart';
import 'package:dpmaker/Utils/DialogHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrameSelection extends StatelessWidget {
  FrameSelection({Key? key}) : super(key: key);
  FrameImageController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(height: 1,color: CustomColors.primary,),
          TabBar(
            controller: controller.frameTabController,
            tabs: List.generate(controller.frameTabController.length, (index) => Tab(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 15),
                decoration: BoxDecoration(
                  color: CustomColors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(framesList[index]['category'].toString(),style: TextStyle(color: Colors.white)),
              ),
            )),
            isScrollable: true,
            indicatorColor: CustomColors.primary,
          ),
          Divider(height: 1,color: CustomColors.primary,),
          Expanded(child: TabBarView(
            controller: controller.frameTabController,
            children:  List.generate(controller.frameTabController.length, (i) => Container(
              child: GridView.builder(
                itemCount: framesList[i]['frames'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      // if(index > 2){
                      //   DialogHelper.AdConfirmationDialog(context,title: "Want to use frame?",desc: "To use this frame, watch ad first. It's worth it!",onYes: () async {
                      //     await AdsHelper.loadAndShowInterstitialPremium(context,onDone: () {
                      //       controller.selectedFrame.value = framesList[i]['frames'][index];
                      //     },);
                      //   },);
                      // } else {
                      registerAnalyticsEvent(name: "frame_${framesList[i]['frames'][index].toString().replaceAll("assets/frames/", "").replaceAll(".png", "").replaceAll("/", "_")}");
                      controller.selectedFrame.value = framesList[i]['frames'][index];
                      // }
                    },
                    child: Stack(
                      children: [
                        framesList[i]['frames'][index].toString().isEmpty ? Container() : CachedNetworkImage( imageUrl: framesList[i]['frames'][index],),
                        // Obx(() => (controller.selectedFrame.value == framesList[i]['frames'][index]) ? Center(child: Icon(Icons.done),) : (index > 2) ? Center(child: Icon(Icons.lock,),) : SizedBox())
                        Obx(() => (controller.selectedFrame.value == framesList[i]['frames'][index]) ? Center(child: Icon(Icons.done),) : SizedBox())
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
