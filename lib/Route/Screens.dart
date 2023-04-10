import 'package:dpmaker/Screens/HomeScreen.dart';
import 'package:dpmaker/Route/Routes.dart';
import 'package:flutter/material.dart';
import 'package:dpmaker/Screens/LoginScreen.dart';

///  this class contains all screens navigation.
///  it helps to centralize all pages with namedRoute.

class Screens{
  static final screens =   <String, WidgetBuilder>{
    Routes.loginScreen: (_) => LoginScreen(), // for arguments =>  var args =  ModalRoute.of(_)?.settings.arguments as Map<String,dynamic>;
    Routes.homeScreen: (_) => HomeScreen(),
  };
}