import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Constants/ImagePath.dart';
import 'package:dpmaker/Controllers/FrameImageController.dart';
import 'package:dpmaker/Utils/AdsHelper.dart';
import 'package:dpmaker/Utils/DialogHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'FrameStickers.dart';

class FrameText extends StatefulWidget {
  TextWidth? stickerText;
  FrameText({Key? key,this.stickerText}) : super(key: key);

  @override
  State<FrameText> createState() => _FrameTextState();
}

class _FrameTextState extends State<FrameText> with SingleTickerProviderStateMixin{
  late TabController tabController;
  TextEditingController textEditingController = TextEditingController();
  String? selectedFont;
  Color? selectedColor;
  FrameImageController controller = Get.find();
  String selectedFrame = "";
  AdsHelper adsHelper = AdsHelper();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    adsHelper.loadBannerAd();
    if(widget.stickerText != null){
      textEditingController.text = widget.stickerText?.text ?? "";
      selectedFrame = widget.stickerText?.selectedFrame ?? "";
      selectedFont = widget.stickerText?.style?.fontFamily;
      selectedColor = widget.stickerText?.style?.color;
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
                      data.frame = selectedFrame;
                      Get.back(result: data);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 22.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: CustomColors.scaffoldBgColor),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: TextWidth(selectedFrame: selectedFrame,text: textEditingController.text,style: TextStyle(color: selectedColor,fontFamily: selectedFont))),
                  ),
                  SizedBox(height: 15,),
                  CustomTextField(
                    controller: textEditingController,
                    hint: "Type something..",
                    filled: true,
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.center,
                    fillColor: CustomColors.primary.withOpacity(0.1),
                    borderColor: CustomColors.primary,
                    fontFamily: selectedFont,
                    fontColor: selectedColor,
                    fontSize: 18,
                    maxLines: 3,
                    maxLength: 200,
                    onChange: (p0) {
                      setState(() {});
                    },
                  ),
                ],
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
                  Tab(
                    child: Image.asset(ImagePath.ic_frames,color: tabController.index == 2 ? CustomColors.primary : CustomColors.black,width: 30,),
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
                Column(
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
                              onTap: () {
                                if(index > 2){
                                  DialogHelper.AdConfirmationDialog(context,title: "Want to use frame?",desc: "To use this frame, watch ad first. It's worth it!",onYes: () async {
                                    await AdsHelper.loadAndShowInterstitialPremium(context,onDone: () {
                                      setState(() {
                                        selectedFrame = framesList[i]['frames'][index];
                                      });
                                    },);
                                  },);
                                } else {
                                  setState(() {
                                    selectedFrame = framesList[i]['frames'][index];
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  framesList[i]['frames'][index].toString().isEmpty ? Container() : Image.asset(framesList[i]['frames'][index]),
                                  (selectedFrame == framesList[i]['frames'][index]) ? Center(child: Icon(Icons.done),) : (index > 2) ? Center(child: Icon(Icons.lock,),) : SizedBox()
                                ],
                              ),
                            );
                          },
                        ),
                      )),
                    )),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: adsHelper.showBannerAd(),
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
        crossAxisCount: 5,
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
  String frame = "";

  TextData();
}

class TextWidth extends StatelessWidget {
  final String text;
  final String selectedFrame;
  final TextStyle? style;

  const TextWidth({Key? key, this.text = "", this.selectedFrame = "", this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final TextPainter textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          textDirection: TextDirection.ltr,
          maxLines: 1,
        )..layout(maxWidth: constraints.maxWidth);
        return Container(
          width: textPainter.width * 1.4,
          height: textPainter.width * 1.4,
          child: Stack(
            children: [
              if(selectedFrame.isNotEmpty) Image.asset(selectedFrame, fit: BoxFit.cover,),
              Center(child: Text(text, style: style,textAlign: TextAlign.center,)),
            ],
          ),
        );
      },
    );
  }
}