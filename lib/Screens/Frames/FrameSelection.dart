import 'package:custom_elements/custom_elements.dart';
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
                child: Text(framesList[index]['category'].toString(),),
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
