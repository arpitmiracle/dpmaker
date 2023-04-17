import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:custom_elements/custom_elements.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
        required this.controller,
        this.radius = 10,
        this.keyboardType,
        this.fontColor,
        this.borderColor = CustomColors.borderColor,
        this.fillColor =    CustomColors.textFieldColor,
        this.boderWidth = 1,
        this.outPadding = 10,
        this.fontSize,
        this.contentPadding,
        this.maxLength,
        this.counter = false,
        this.hint = '',
        this.obscureText = false,
        this.textAlign,
        this.enabled,
        this.onChange,
        this.validator,
        this.displayError = false,
        this.height,
        this.errorTextStyle,
        this.border,
        this.fontFamily,
        this.filled = false,
      });

  final TextEditingController controller;
  double radius;
  Color? fontColor;
  Color borderColor;
  bool displayError;
  Color fillColor;
  double boderWidth;
  bool? enabled;
  double? height;
  double? fontSize;
  double outPadding;
  EdgeInsets? contentPadding;
  int? maxLength;
  bool counter;
  bool obscureText;
  String hint;
  TextInputType? keyboardType;
  TextAlign? textAlign;
  TextStyle? errorTextStyle;
  List<TextInputFormatter>? inputFormatter;
  int? maxLines;
  Function(String)? onChange;
  String? Function(String?)? validator;
  InputBorder? border;
  bool filled;
  String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(outPadding),
      child: SizedBox(
        height: height,
        child: TextFormField(
          style: CustomStyles.textStyle(fontSize: fontSize,fontFamily: fontFamily,fontColor: fontColor),
          controller: controller,
          expands: false,
          inputFormatters: inputFormatter,
          maxLines: maxLines ?? 1,
          onChanged: onChange,
          enabled: enabled,
          keyboardType: keyboardType,
          autofocus: false,
          textAlign: textAlign ?? TextAlign.start,
          obscureText: obscureText,
          validator: validator,
          maxLength: maxLength,
          decoration: InputDecoration(
              filled: filled,
              counterText:  counter ? null : '',
              contentPadding: contentPadding,
              fillColor: fillColor,
              enabledBorder: border ?? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: borderColor,
                      width: boderWidth),
                  borderRadius: BorderRadius.circular(radius)),
              disabledBorder: border ?? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: borderColor.withOpacity(0.2),
                      width: boderWidth),
                  borderRadius: BorderRadius.circular(radius)),
              focusedBorder: border ?? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: borderColor,
                      width: boderWidth),
                  borderRadius: BorderRadius.circular(radius)),
              border: border ?? OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.text)),
              // errorText: '',
              errorStyle:  displayError ? errorTextStyle ?? CustomStyles.textStyle() : TextStyle(fontSize: 0),
              hintText: hint),
        ),
      ),
    );
  }
}
