import 'package:custom_elements/custom_elements.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  double? fontSize;
  EdgeInsets? padding;
  double? radius;
  Function onTap;
  Color bgColor;
  double elevation;
  Color fgColor;
  Color pressedColor;
  String title;
  double borderWidth;
  Color borderColor;
  Size? size;
  bool shrink;

  CustomButton(
      {super.key, required this.title,
      this.radius,
        this.borderWidth = 0,
      this.borderColor = Colors.transparent,
      this.padding,
      this.fontSize,
      required this.onTap,
      this.bgColor = CustomColors.buttonColor,
      this.elevation = 0,
      this.pressedColor = CustomColors.primary,
      this.size,
        this.shrink = false,
      this.fgColor = CustomColors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      clipBehavior: Clip.antiAlias,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          foregroundColor: MaterialStateProperty.all(fgColor),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: MaterialStateProperty.all(BorderSide(color: borderColor,style: BorderStyle.solid,width: borderWidth)),
          elevation: MaterialStateProperty.all(elevation),
          padding: MaterialStateProperty.all(    padding ?? const EdgeInsets.symmetric(horizontal: 10,vertical: 5)),
          overlayColor: MaterialStateProperty.all(pressedColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 30))),
          animationDuration: const Duration(milliseconds: 500),
          splashFactory: InkSplash.splashFactory,
           maximumSize: shrink ? null : MaterialStateProperty.all(size ?? (Size(60.w, 6.h))),
           minimumSize: shrink ? null : MaterialStateProperty.all(size ?? (Size(60.w, 6.h))),
          visualDensity: VisualDensity.standard,
          // padding: MaterialStateProperty.all(EdgeInsets.all(20)),
          // surfaceTintColor:  MaterialStateProperty.all(Colors.greenAccent)
      ),

      child:  Text(title,style: CustomStyles.textStyle(fontSize:  fontSize),),
    );
  }
}
