import 'dart:io';

import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Localization/AppStrings.dart';
import 'package:dpmaker/Utils/Extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

///  this class contains small functions like validation and checking
///  functions that we can use in all pages.

class Utils {
 static showToast(String value) {
  Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_SHORT
  );
 }

 static bool isValidEmail(String? value) => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value ?? '');
 static bool isValidPhoneNumber(String? value) => RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)').hasMatch(value ?? '');

 static Future<bool> isInternetConnected()async{
  try {
   final result = await InternetAddress.lookup('https://www.google.com');
   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    return true;
   }
  } on SocketException catch (_) {
   printLog('not internet connected');
  }
  return false;
 }
}

DateTime? currentBackPressTime;

Future<bool> onWillPop(BuildContext context) {
 DateTime now = DateTime.now();
 if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
  currentBackPressTime = now;

  Utils.showToast(AppStrings.exit_msg.localized(context),);
  return Future.value(false);
 }
 return Future.value(true);
}

Future<bool> backPressed(BuildContext context) async {
 bool back = await onWillPop(context );
 if (back) {
  if (Platform.isAndroid)
   SystemNavigator.pop();
  else
   exit(0);
 }
 return back;
}