import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
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
                child: Text(stickersList[index]['category'].toString(),),
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
                    onTap: () {
                      // controller.selectedSticker.value = stickersList[i]['stickers'][index];
                      controller.stickerList.add(Sticker(id: "Sticker$index${DateTime.now().hashCode}",child: Container(height: 40,width: 40,child: Center(child: Image.asset(stickersList[i]['stickers'][index],fit: BoxFit.cover,))),));
                      controller.update();
                    },
                    child: Image.asset(stickersList[i]['stickers'][index]),
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
