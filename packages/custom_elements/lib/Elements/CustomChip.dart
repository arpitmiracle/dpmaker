import 'package:custom_elements/custom_elements.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  CustomChip({super.key, required this.isSelected,required this.text, this.onTap});
  bool isSelected;
  String text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(text,style: TextStyle(color: isSelected ? CustomColors.primary : CustomColors.scaffoldBgColor,fontSize: 12.sp,fontWeight: FontWeight.bold),),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        side: BorderSide(color: CustomColors.primary,width: 1.5),
        backgroundColor: isSelected ? CustomColors.white : CustomColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 1.2.h),
      ),
    );
  }
}
