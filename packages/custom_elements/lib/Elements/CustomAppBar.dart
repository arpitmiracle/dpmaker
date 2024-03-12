import 'package:flutter/material.dart';
import 'package:custom_elements/custom_elements.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  Widget? customTitle;
  double? height;
  double? iconSize;
  Function? prefixAction;
  Function? suffixAction;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool isSafeArea;
  Gradient? gradient;

  CustomAppBar({Key? key, required this.title,this.height,this.prefixAction,this.suffixIcon,this.prefixIcon,this.suffixAction,this.iconSize,this.customTitle,this.isSafeArea = true,this.gradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isSafeArea ? EdgeInsets.only(top: MediaQuery.of(context).padding.top) : EdgeInsets.zero,
      decoration: BoxDecoration(color: CustomColors.primary,gradient: gradient),
      child: Container(
        height: height ?? preferredSize.height,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  <Widget>[
              SizedBox(
                height: iconSize ?? (15.w),
                width:  iconSize ?? (15.w),
                child: Center(
                  child: InkWell(
                    onTap:  ()=> prefixAction != null ? prefixAction!() : null,
                    child: prefixIcon ?? SizedBox(),
                  ),
                ),
              ),
              Expanded(child:Center(child:  customTitle ??  CustomTitle(title: title,fontColor: CustomColors.scaffoldBgColor,))),
              SizedBox(
                height: iconSize ?? (15.w),
                width:  iconSize ?? (15.w),
                child: Center(
                  child: InkWell(
                    onTap:  ()=> suffixAction != null ? suffixAction!() : null,
                    child: suffixIcon ?? SizedBox(),
                  ) ,
                ),
              ),
            ]),
      ),
    );
  }

  @override
  Size get preferredSize => Size(100.w, height ?? (8.h));
}
