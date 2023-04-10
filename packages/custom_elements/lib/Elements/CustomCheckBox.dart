import 'package:custom_elements/custom_elements.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({this.initVal = false, required this.onChnage,this.scale,this.fgColor,this.bgColor,this.borderColor,this.shape,this.radius});

  bool initVal;
  Function(bool) onChnage;
  double? scale;
  double? radius;
  Color? bgColor;
  Color? fgColor;
  Color? borderColor;
  OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> value = ValueNotifier<bool>(initVal);
    return Transform.scale(
      scale: scale ?? 1.3,
      child: ValueListenableBuilder(
        valueListenable: value,
        builder: (context, val, child) => Checkbox(
        value: val,
        onChanged: (val) {
          value.value = val ?? false;
          onChnage(val ?? value.value);
        },
        splashRadius: 5.w,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 5)),
        side: BorderSide(color:  borderColor ??  CustomColors.buttonColor, width: 2),
        fillColor: MaterialStateProperty.all(bgColor ?? CustomColors.buttonColor),
        checkColor: fgColor,
        overlayColor: MaterialStateProperty.all(CustomColors.primary.withOpacity(0.1)),
      ),),
    );


  }
}
