import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
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
          TabBar(
            controller: controller.frameTabController,
            tabs: List.generate(controller.frameTabController.length, (index) => Tab(
              child: Center(child: Text(framesList[index]['category'].toString(),maxLines: 1,style: TextStyle(color: Colors.black))),
            )),
            isScrollable: true,
          ),
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
                    onTap: () {
                      controller.selectedFrame.value = framesList[i]['frames'][index];
                    },
                    child: Image.asset(framesList[i]['frames'][index]),
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
