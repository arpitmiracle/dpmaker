import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              child: Center(child: Text(stickersList[index]['category'].toString(),maxLines: 1,style: TextStyle(color: Colors.black))),
            )),
            isScrollable: true,
          ),
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
                      controller.selectedSticker.value = stickersList[i]['stickers'][index];
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
