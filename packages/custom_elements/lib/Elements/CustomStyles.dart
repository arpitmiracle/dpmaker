import 'package:custom_elements/custom_elements.dart';
import 'package:flutter/material.dart';

class CustomStyles {
  static TextStyle textStyle(
      {String? fontFamily,
      double? fontSize,
      Color? fontColor,
        TextDecoration? textDecoration,
        FontStyle? fontStyle,
      FontWeight? fontWeight}) {
    return TextStyle(
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: textDecoration,
        fontSize: fontSize ?? (12.sp),
        color: fontColor,
        fontWeight: fontWeight);
  }
}
