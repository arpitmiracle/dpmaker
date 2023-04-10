import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_elements/custom_elements.dart';

class CustomText extends StatelessWidget {
  CustomText({required this.text, this.color,this.fontWeight,this.maxLines,this.fontSize});

  String text;
  Color? color;
  FontWeight? fontWeight;
  double? fontSize;
  int? maxLines;
  TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: CustomStyles.textStyle(
        fontSize: fontSize,
        fontColor: color,
        fontWeight: fontWeight
      ),
    );
  }
}
