import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Localization/AppStrings.dart';
import 'package:dpmaker/Utils/Extentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogHelper {
  static Future showSelectTypeDialog(BuildContext context, {required Function(int) onTypeTap}) async {
    return  showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    color: CustomColors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 8.h,
                          color: CustomColors.primary,
                          child: Center(
                            child: CustomText(
                              text: AppStrings.select_type.toLocalized(context),
                              color: CustomColors.scaffoldBgColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(7.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () => onTypeTap(1),
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: CustomColors.scaffoldBgColor),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.camera_alt,color: CustomColors.scaffoldBgColor,size: 35,),
                                ),
                              ),
                              InkWell(
                                onTap: () => onTypeTap(2),
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: CustomColors.scaffoldBgColor),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.photo_size_select_actual,color: CustomColors.scaffoldBgColor,size: 35,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  static AdConfirmationDialog(BuildContext context,{required String title,required String desc,required VoidCallback onYes}) {
    return Alert(
      context: context,
      type: AlertType.warning,
      style: AlertStyle(
          overlayColor: CustomColors.text,
          alertBorder: RoundedRectangleBorder(
              side: BorderSide(color: CustomColors.primary),
              borderRadius: BorderRadius.circular(10)),
          titleStyle: TextStyle(
            color: Theme.of(context).textTheme.headline1?.color,
          ),
          descStyle: TextStyle(color: CustomColors.grey)),
      title: title,
      desc: desc,
      closeIcon: Icon(Icons.close),
      buttons: [
        DialogButton(
          child: CustomTitle(
            title: "Cancel",
            fontColor: CustomColors.white,
            fontWeight: FontWeight.normal,
          ),
          onPressed: () => Navigator.pop(context),
          color: CustomColors.red,
        ),
        DialogButton(
          child: CustomTitle(
            title: "Continue",
            fontColor: CustomColors.white,
            fontWeight: FontWeight.normal,
          ),
          onPressed: () {
            Navigator.pop(context);
            onYes.call();
          },
          color: CustomColors.green,
        ),
      ],
    ).show();
  }

}
