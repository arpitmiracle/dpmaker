import 'package:dpmaker/Screens/HomeScreen.dart';
import 'package:dpmaker/Route/Routes.dart';
import 'package:flutter/material.dart';

///  this class contains all screens navigation.
///  it helps to centralize all pages with namedRoute.

class Screens{
  static final screens =   <String, WidgetBuilder>{
    Routes.homeScreen: (_) => HomeScreen(), // for arguments =>  var args =  ModalRoute.of(_)?.settings.arguments as Map<String,dynamic>;
   };
}