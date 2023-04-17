import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrameText extends StatefulWidget {
  CustomText? stickerText;
  FrameText({Key? key,this.stickerText}) : super(key: key);

  @override
  State<FrameText> createState() => _FrameTextState();
}

class _FrameTextState extends State<FrameText> with SingleTickerProviderStateMixin{
  late TabController tabController;
  TextEditingController textEditingController = TextEditingController();
  String? selectedFont;
  Color? selectedColor;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    if(widget.stickerText != null){
      textEditingController.text = widget.stickerText?.text ?? "";
      selectedFont = widget.stickerText?.fontFamily;
      selectedColor = widget.stickerText?.color;
      setState(() {});
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Image.asset(ImagePath.ic_back),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  InkWell(
                    child: Image.asset(ImagePath.ic_done),
                    onTap: () async {
                      TextData data = TextData();
                      data.text = textEditingController.text.trim();
                      data.color = selectedColor;
                      data.font = selectedFont;
                      Get.back(result: data);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35.h,
              child: Center(
                child: CustomTextField(
                  controller: textEditingController,
                  hint: "Type something..",
                  filled: true,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  fillColor: CustomColors.primary.withOpacity(0.1),
                  borderColor: CustomColors.primary,
                  fontFamily: selectedFont,
                  fontColor: selectedColor,
                  fontSize: 18,
                ),
              ),
            ),
            Divider(height: 1,color: CustomColors.primary,),
            Container(
              width: 60.w,
              child: TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    child: Image.asset(ImagePath.ic_color,color: tabController.index == 0 ? CustomColors.primary : CustomColors.black,width: 30,),
                  ),
                  Tab(
                    child: Image.asset(ImagePath.ic_fonts,color: tabController.index == 1 ? CustomColors.primary : CustomColors.black,width: 30,),
                  ),
                ],
                indicatorColor: CustomColors.primary,
                onTap: (value) {
                  setState(() {});
                },
              ),
            ),
            Divider(height: 1,color: CustomColors.primary,),
            Expanded(child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                getColorsView(),
                getFontsView(),
              ],
            )),
          ],
        ),
      ),
    );
  }

  getFontsView(){
    return GridView.builder(
      itemCount: fontsList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedFont = fontsList[index];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: CustomColors.primary),
              shape: BoxShape.circle,
              color: fontsList[index] == selectedFont ? CustomColors.primary : Colors.transparent,
            ),
            child: Center(child: Text("Aa",style: TextStyle(fontFamily: fontsList[index]),)),
          ),
        );
      },
    );
  }

  getColorsView(){
    return GridView.builder(
      itemCount: colorsList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedColor = colorsList[index];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorsList[index],
            ),
          ),
        );
      },
    );
  }
}

class TextData {
  String text = "";
  Color? color;
  String? font;

  TextData();
}