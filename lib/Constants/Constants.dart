import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as d;

///  this file contains all constant value that are used in other app.
///  it helps to centralize all constant values.

const DEBUG = true;
const InDevelopment = true;
const defaultFontFamily = null;
ValueNotifier<Locale> currentAppLocal = ValueNotifier(Locale('en',''));
List<Locale> supportedLocales = const [
  Locale('en'),
  Locale('ar'),
];

void printLog(String val){
  if(DEBUG) d.log(val);
}

registerAnalyticsEvent({required String name,}){
  FirebaseAnalytics.instance.logEvent(name: name, parameters: {'time': '${DateTime.now()}'});
}

class EventType {
  static String homeScreen = "home_screen";
  static String myAlbumScreen = "my_album_screen";
  static String frameImageScreen = "frame_image_screen";
  static String cropImageScreen = "crop_image_screen";
  static String download_image = "download_image";
}

bool checkResponse(int? code){
  return code == 200 ? true : false;
}

List fontsList = List.generate(41, (index) => "style${index + 1}");
List<Color> colorsList = [
  Colors.black,
  Colors.white,
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.pink,
  Colors.purple,
  Colors.orange,
  Colors.teal,
  Colors.brown,
  Colors.grey,
  Colors.indigo,
  Colors.lime,
  Colors.amber,
  Colors.cyan,
  Colors.deepPurple,
  Colors.deepOrange,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.redAccent,
  Colors.blueAccent,
  Colors.greenAccent,
  Colors.yellowAccent,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.orangeAccent,
  Colors.tealAccent,
  Colors.brown.shade900,
  Colors.grey.shade900,
  Colors.indigo.shade900,
  Colors.lime.shade900,
  Colors.amber.shade900,
  Colors.cyan.shade900,
  Colors.deepPurple.shade900,
  Colors.deepOrange.shade900,
  Colors.lightBlue.shade900,
  Colors.lightGreen.shade900,
  Colors.redAccent.shade700,
  Colors.blueAccent.shade700,
  Colors.greenAccent.shade700,
  Colors.yellowAccent.shade700,
  Colors.pinkAccent.shade700,
  Colors.purpleAccent.shade700,
  Colors.orangeAccent.shade700,
  Colors.tealAccent.shade700,
  Colors.black54,
  Colors.grey.shade500,
  Colors.grey.shade800,
  Colors.blueGrey,
];

List framesList = [
  {
    "category" : "Basic",
    "frames" : [
      "",
      "assets/frames/Basic/border_basic_02.png",
      "assets/frames/Basic/border_basic_03.png",
      "assets/frames/Basic/border_basic_04.png",
      "assets/frames/Basic/border_basic_05.png",
      "assets/frames/Basic/border_basic_06.png",
      "assets/frames/Basic/border_basic_07.png",
      "assets/frames/Basic/border_basic_08.png",
      "assets/frames/Basic/border_basic_09.png",
      "assets/frames/Basic/border_basic_10.png",
      "assets/frames/Basic/border_basic_11.png",
      "assets/frames/Basic/border_basic_12.png",
      "assets/frames/Basic/border_basic_13.png",
      "assets/frames/Basic/border_basic_14.png",
      "assets/frames/Basic/border_basic_15.png",
      "assets/frames/Basic/border_basic_16.png",
      "assets/frames/Basic/border_basic_17.png",
      "assets/frames/Basic/border_basic_18.png",
      "assets/frames/Basic/border_basic_19.png",
      "assets/frames/Basic/border_basic_20.png",
      "assets/frames/Basic/border_basic_21.png",
      "assets/frames/Basic/border_basic_22.png",
      "assets/frames/Basic/border_basic_23.png",
      "assets/frames/Basic/border_basic_24.png",
      "assets/frames/Basic/border_basic_25.png",
      "assets/frames/Basic/border_basic_26.png",
      "assets/frames/Basic/border_basic_27.png",
      "assets/frames/Basic/border_basic_28.png",
      "assets/frames/Basic/border_basic_29.png",
      "assets/frames/Basic/border_basic_30.png",
      "assets/frames/Basic/border_basic_31.png",
      "assets/frames/Basic/border_basic_32.png",
      "assets/frames/Basic/border_basic_33.png",
      "assets/frames/Basic/border_basic_34.png",
      "assets/frames/Basic/border_basic_35.png",
      "assets/frames/Basic/border_basic_36.png",
      "assets/frames/Basic/border_basic_37.png",
      "assets/frames/Basic/border_basic_38.png",
      "assets/frames/Basic/border_basic_39.png",
      "assets/frames/Basic/border_basic_40.png",
      "assets/frames/Basic/border_basic_41.png",
      "assets/frames/Basic/border_basic_42.png",
      "assets/frames/Basic/border_basic_43.png",
      "assets/frames/Basic/border_basic_44.png",
      "assets/frames/Basic/border_basic_45.png",
      "assets/frames/Basic/border_basic_46.png",
      "assets/frames/Basic/border_basic_47.png",
      "assets/frames/Basic/border_basic_48.png",
      "assets/frames/Basic/border_basic_49.png",
      "assets/frames/Basic/border_basic_50.png",
      "assets/frames/Basic/border_basic_51.png",
      "assets/frames/Basic/border_basic_52.png",
      "assets/frames/Basic/border_basic_53.png",
      "assets/frames/Basic/border_basic_54.png",
      "assets/frames/Basic/border_basic_55.png",
      "assets/frames/Basic/border_basic_56.png",
      "assets/frames/Basic/border_basic_57.png",
      "assets/frames/Basic/border_basic_58.png",
      "assets/frames/Basic/border_basic_59.png",
      "assets/frames/Basic/border_basic_60.png",
      "assets/frames/Basic/border_basic_61.png",
      "assets/frames/Basic/border_basic_62.png",
      "assets/frames/Basic/border_basic_63.png",
      "assets/frames/Basic/border_basic_64.png",
      "assets/frames/Basic/border_basic_65.png",
      "assets/frames/Basic/border_basic_66.png",
      "assets/frames/Basic/border_basic_67.png",
      "assets/frames/Basic/border_basic_68.png",
      "assets/frames/Basic/border_basic_69.png",
      "assets/frames/Basic/border_basic_70.png",
      "assets/frames/Basic/border_basic_71.png",
      "assets/frames/Basic/border_basic_72.png",
      "assets/frames/Basic/border_basic_73.png",
      "assets/frames/Basic/border_basic_74.png",
      "assets/frames/Basic/border_basic_75.png",
      "assets/frames/Basic/border_basic_76.png",
      "assets/frames/Basic/border_basic_77.png",
      "assets/frames/Basic/border_basic_78.png",
      "assets/frames/Basic/border_basic_79.png",
      "assets/frames/Basic/border_basic_80.png",
      "assets/frames/Basic/border_basic_81.png",
      "assets/frames/Basic/border_basic_82.png",
      "assets/frames/Basic/border_basic_83.png",
      "assets/frames/Basic/border_basic_84.png",
      "assets/frames/Basic/border_basic_85.png",
      "assets/frames/Basic/border_basic_86.png",
    ],
  },
  {
    "category" : "Black",
    "frames" : [
      "",
      "assets/frames/Black/border_black_01.png",
      "assets/frames/Black/border_black_02.png",
      "assets/frames/Black/border_black_03.png",
      "assets/frames/Black/border_black_04.png",
      "assets/frames/Black/border_black_05.png",
      "assets/frames/Black/border_black_06.png",
      "assets/frames/Black/border_black_07.png",
      "assets/frames/Black/border_black_08.png",
      "assets/frames/Black/border_black_09.png",
      "assets/frames/Black/border_black_10.png",
      "assets/frames/Black/border_black_11.png",
      "assets/frames/Black/border_black_12.png",
      "assets/frames/Black/border_black_13.png",
      "assets/frames/Black/border_black_14.png",
      "assets/frames/Black/border_black_15.png",
      "assets/frames/Black/border_black_16.png",
      "assets/frames/Black/border_black_17.png",
      "assets/frames/Black/border_black_18.png",
      "assets/frames/Black/border_black_19.png",
      "assets/frames/Black/border_black_20.png",
      "assets/frames/Black/border_black_21.png",
      "assets/frames/Black/border_black_22.png",
      "assets/frames/Black/border_black_23.png",
      "assets/frames/Black/border_black_24.png",
      "assets/frames/Black/border_black_25.png",
      "assets/frames/Black/border_black_26.png",
      "assets/frames/Black/border_black_27.png",
      "assets/frames/Black/border_black_28.png",
      "assets/frames/Black/border_black_29.png",
    ],
  },
  {
    "category" : "Colorful",
    "frames" : [
      "",
      "assets/frames/Colorful/border_colorful_01.png",
      "assets/frames/Colorful/border_colorful_02.png",
      "assets/frames/Colorful/border_colorful_03.png",
      "assets/frames/Colorful/border_colorful_04.png",
      "assets/frames/Colorful/border_colorful_05.png",
      "assets/frames/Colorful/border_colorful_06.png",
      "assets/frames/Colorful/border_colorful_07.png",
      "assets/frames/Colorful/border_colorful_08.png",
      "assets/frames/Colorful/border_colorful_09.png",
      "assets/frames/Colorful/border_colorful_10.png",
      "assets/frames/Colorful/border_colorful_11.png",
      "assets/frames/Colorful/border_colorful_12.png",
      "assets/frames/Colorful/border_colorful_13.png",
      "assets/frames/Colorful/border_colorful_14.png",
      "assets/frames/Colorful/border_colorful_15.png",
      "assets/frames/Colorful/border_colorful_16.png",
      "assets/frames/Colorful/border_colorful_17.png",
      "assets/frames/Colorful/border_colorful_18.png",
      "assets/frames/Colorful/border_colorful_19.png",
      "assets/frames/Colorful/border_colorful_20.png",
      "assets/frames/Colorful/border_colorful_21.png",
      "assets/frames/Colorful/border_colorful_22.png",
      "assets/frames/Colorful/border_colorful_23.png",
      "assets/frames/Colorful/border_colorful_24.png",
      "assets/frames/Colorful/border_colorful_25.png",
      "assets/frames/Colorful/border_colorful_26.png",
      "assets/frames/Colorful/border_colorful_27.png",
      "assets/frames/Colorful/border_colorful_28.png",
      "assets/frames/Colorful/border_colorful_29.png",
      "assets/frames/Colorful/border_colorful_30.png",
      "assets/frames/Colorful/border_colorful_31.png",
      "assets/frames/Colorful/border_colorful_32.png",
      "assets/frames/Colorful/border_colorful_33.png",
      "assets/frames/Colorful/border_colorful_34.png",
      "assets/frames/Colorful/border_colorful_35.png",
      "assets/frames/Colorful/border_colorful_36.png",
      "assets/frames/Colorful/border_colorful_37.png",
      "assets/frames/Colorful/border_colorful_38.png",
      "assets/frames/Colorful/border_colorful_39.png",
      "assets/frames/Colorful/border_colorful_40.png",
    ],
  },
  {
    "category" : "Cute",
    "frames" : [
      "",
      "assets/frames/Cute/border_cute_01.png",
      "assets/frames/Cute/border_cute_02.png",
      "assets/frames/Cute/border_cute_03.png",
      "assets/frames/Cute/border_cute_04.png",
      "assets/frames/Cute/border_cute_05.png",
      "assets/frames/Cute/border_cute_06.png",
      "assets/frames/Cute/border_cute_07.png",
      "assets/frames/Cute/border_cute_08.png",
      "assets/frames/Cute/border_cute_09.png",
      "assets/frames/Cute/border_cute_10.png",
      "assets/frames/Cute/border_cute_11.png",
      "assets/frames/Cute/border_cute_12.png",
      "assets/frames/Cute/border_cute_13.png",
      "assets/frames/Cute/border_cute_14.png",
      "assets/frames/Cute/border_cute_15.png",
      "assets/frames/Cute/border_cute_16.png",
      "assets/frames/Cute/border_cute_17.png",
      "assets/frames/Cute/border_cute_18.png",
      "assets/frames/Cute/border_cute_19.png",
      "assets/frames/Cute/border_cute_20.png",
      "assets/frames/Cute/border_cute_21.png",
      "assets/frames/Cute/border_cute_22.png",
      "assets/frames/Cute/border_cute_23.png",
      "assets/frames/Cute/border_cute_24.png",
      "assets/frames/Cute/border_cute_25.png",
      "assets/frames/Cute/border_cute_26.png",
      "assets/frames/Cute/border_cute_27.png",
      "assets/frames/Cute/border_cute_28.png",
      "assets/frames/Cute/border_cute_29.png",
      "assets/frames/Cute/border_cute_30.png",
      "assets/frames/Cute/border_cute_31.png",
      "assets/frames/Cute/border_cute_32.png",
      "assets/frames/Cute/border_cute_33.png",
      "assets/frames/Cute/border_cute_34.png",
      "assets/frames/Cute/border_cute_35.png",
      "assets/frames/Cute/border_cute_36.png",
      "assets/frames/Cute/border_cute_37.png",
      "assets/frames/Cute/border_cute_38.png",
      "assets/frames/Cute/border_cute_39.png",
      "assets/frames/Cute/border_cute_40.png",
      "assets/frames/Cute/border_cute_41.png",
    ],
  },
  {
    "category" : "Flowers",
    "frames" : [
      "",
      "assets/frames/Flowers/border_flower_01.png",
      "assets/frames/Flowers/border_flower_02.png",
      "assets/frames/Flowers/border_flower_03.png",
      "assets/frames/Flowers/border_flower_04.png",
      "assets/frames/Flowers/border_flower_05.png",
      "assets/frames/Flowers/border_flower_06.png",
      "assets/frames/Flowers/border_flower_07.png",
      "assets/frames/Flowers/border_flower_08.png",
      "assets/frames/Flowers/border_flower_09.png",
      "assets/frames/Flowers/border_flower_10.png",
      "assets/frames/Flowers/border_flower_11.png",
      "assets/frames/Flowers/border_flower_12.png",
      "assets/frames/Flowers/border_flower_13.png",
      "assets/frames/Flowers/border_flower_14.png",
      "assets/frames/Flowers/border_flower_15.png",
      "assets/frames/Flowers/border_flower_16.png",
      "assets/frames/Flowers/border_flower_17.png",
      "assets/frames/Flowers/border_flower_18.png",
      "assets/frames/Flowers/border_flower_19.png",
      "assets/frames/Flowers/border_flower_20.png",
      "assets/frames/Flowers/border_flower_21.png",
      "assets/frames/Flowers/border_flower_22.png",
      "assets/frames/Flowers/border_flower_23.png",
      "assets/frames/Flowers/border_flower_24.png",
      "assets/frames/Flowers/border_flower_25.png",
      "assets/frames/Flowers/border_flower_26.png",
      "assets/frames/Flowers/border_flower_27.png",
      "assets/frames/Flowers/border_flower_28.png",
      "assets/frames/Flowers/border_flower_29.png",
      "assets/frames/Flowers/border_flower_30.png",
      "assets/frames/Flowers/border_flower_31.png",
      "assets/frames/Flowers/border_flower_32.png",
      "assets/frames/Flowers/border_flower_33.png",
      "assets/frames/Flowers/border_flower_34.png",
      "assets/frames/Flowers/border_flower_35.png",
      "assets/frames/Flowers/border_flower_36.png",
      "assets/frames/Flowers/border_flower_37.png",
      "assets/frames/Flowers/border_flower_38.png",
      "assets/frames/Flowers/border_flower_39.png",
      "assets/frames/Flowers/border_flower_40.png",
      "assets/frames/Flowers/border_flower_41.png",
      "assets/frames/Flowers/border_flower_42.png",
      "assets/frames/Flowers/border_flower_43.png",
      "assets/frames/Flowers/border_flower_44.png",
      "assets/frames/Flowers/border_flower_45.png",
      "assets/frames/Flowers/border_flower_46.png",
      "assets/frames/Flowers/border_flower_47.png",
      "assets/frames/Flowers/border_flower_48.png",
      "assets/frames/Flowers/border_flower_49.png",
      "assets/frames/Flowers/border_flower_50.png",
      "assets/frames/Flowers/border_flower_51.png",
      "assets/frames/Flowers/border_flower_52.png",
      "assets/frames/Flowers/border_flower_53.png",
      "assets/frames/Flowers/border_flower_54.png",
      "assets/frames/Flowers/border_flower_55.png",
      "assets/frames/Flowers/border_flower_56.png",
    ],
  },
  {
    "category" : "Gold",
    "frames" : [
      "",
      "assets/frames/Gold/border_gold_00.png",
      "assets/frames/Gold/border_gold_01.png",
      "assets/frames/Gold/border_gold_02.png",
      "assets/frames/Gold/border_gold_03.png",
      "assets/frames/Gold/border_gold_04.png",
      "assets/frames/Gold/border_gold_05.png",
      "assets/frames/Gold/border_gold_06.png",
      "assets/frames/Gold/border_gold_07.png",
      "assets/frames/Gold/border_gold_08.png",
      "assets/frames/Gold/border_gold_09.png",
      "assets/frames/Gold/border_gold_10.png",
      "assets/frames/Gold/border_gold_11.png",
      "assets/frames/Gold/border_gold_12.png",
      "assets/frames/Gold/border_gold_13.png",
      "assets/frames/Gold/border_gold_14.png",
      "assets/frames/Gold/border_gold_15.png",
      "assets/frames/Gold/border_gold_16.png",
      "assets/frames/Gold/border_gold_17.png",
      "assets/frames/Gold/border_gold_18.png",
      "assets/frames/Gold/border_gold_19.png",
      "assets/frames/Gold/border_gold_20.png",
      "assets/frames/Gold/border_gold_21.png",
      "assets/frames/Gold/border_gold_22.png",
      "assets/frames/Gold/border_gold_23.png",
      "assets/frames/Gold/border_gold_24.png",
      "assets/frames/Gold/border_gold_25.png",
      "assets/frames/Gold/border_gold_26.png",
      "assets/frames/Gold/border_gold_27.png",
      "assets/frames/Gold/border_gold_28.png",
      "assets/frames/Gold/border_gold_29.png",
      "assets/frames/Gold/border_gold_30.png",
    ],
  },
  {
    "category" : "Minimal",
    "frames" : [
      "",
      "assets/frames/Minimal/border_minimal_01.png",
      "assets/frames/Minimal/border_minimal_02.png",
      "assets/frames/Minimal/border_minimal_03.png",
      "assets/frames/Minimal/border_minimal_04.png",
      "assets/frames/Minimal/border_minimal_05.png",
      "assets/frames/Minimal/border_minimal_06.png",
      "assets/frames/Minimal/border_minimal_07.png",
      "assets/frames/Minimal/border_minimal_08.png",
      "assets/frames/Minimal/border_minimal_09.png",
      "assets/frames/Minimal/border_minimal_10.png",
      "assets/frames/Minimal/border_minimal_11.png",
      "assets/frames/Minimal/border_minimal_12.png",
      "assets/frames/Minimal/border_minimal_13.png",
      "assets/frames/Minimal/border_minimal_14.png",
      "assets/frames/Minimal/border_minimal_15.png",
      "assets/frames/Minimal/border_minimal_16.png",
      "assets/frames/Minimal/border_minimal_17.png",
      "assets/frames/Minimal/border_minimal_18.png",
      "assets/frames/Minimal/border_minimal_19.png",
      "assets/frames/Minimal/border_minimal_20.png",
      "assets/frames/Minimal/border_minimal_21.png",
      "assets/frames/Minimal/border_minimal_22.png",
      "assets/frames/Minimal/border_minimal_23.png",
      "assets/frames/Minimal/border_minimal_24.png",
      "assets/frames/Minimal/border_minimal_25.png",
      "assets/frames/Minimal/border_minimal_26.png",
      "assets/frames/Minimal/border_minimal_27.png",
      "assets/frames/Minimal/border_minimal_28.png",
      "assets/frames/Minimal/border_minimal_29.png",
      "assets/frames/Minimal/border_minimal_30.png",
      "assets/frames/Minimal/border_minimal_31.png",
      "assets/frames/Minimal/border_minimal_32.png",
      "assets/frames/Minimal/border_minimal_33.png",
      "assets/frames/Minimal/border_minimal_34.png",
      "assets/frames/Minimal/border_minimal_35.png",
      "assets/frames/Minimal/border_minimal_36.png",
      "assets/frames/Minimal/border_minimal_37.png",
      "assets/frames/Minimal/border_minimal_38.png",
      "assets/frames/Minimal/border_minimal_39.png",
      "assets/frames/Minimal/border_minimal_40.png",
      "assets/frames/Minimal/border_minimal_41.png",
      "assets/frames/Minimal/border_minimal_42.png",
      "assets/frames/Minimal/border_minimal_43.png",
      "assets/frames/Minimal/border_minimal_44.png",
      "assets/frames/Minimal/border_minimal_45.png",
      "assets/frames/Minimal/border_minimal_46.png",
      "assets/frames/Minimal/border_minimal_47.png",
      "assets/frames/Minimal/border_minimal_48.png",
      "assets/frames/Minimal/border_minimal_49.png",
      "assets/frames/Minimal/border_minimal_50.png",
      "assets/frames/Minimal/border_minimal_51.png",
      "assets/frames/Minimal/border_minimal_52.png",
      "assets/frames/Minimal/border_minimal_53.png",
      "assets/frames/Minimal/border_minimal_54.png",
    ],
  },
  {
    "category" : "Neon",
    "frames" : [
      "",
      "assets/frames/Neon/border_neon_01.png",
      "assets/frames/Neon/border_neon_02.png",
      "assets/frames/Neon/border_neon_03.png",
      "assets/frames/Neon/border_neon_04.png",
      "assets/frames/Neon/border_neon_05.png",
      "assets/frames/Neon/border_neon_06.png",
      "assets/frames/Neon/border_neon_07.PNG",
      "assets/frames/Neon/border_neon_08.png",
      "assets/frames/Neon/border_neon_09.png",
      "assets/frames/Neon/border_neon_10.png",
      "assets/frames/Neon/border_neon_11.png",
      "assets/frames/Neon/border_neon_12.png",
      "assets/frames/Neon/border_neon_13.png",
      "assets/frames/Neon/border_neon_14.png",
      "assets/frames/Neon/border_neon_15.png",
      "assets/frames/Neon/border_neon_16.png",
      "assets/frames/Neon/border_neon_17.png",
      "assets/frames/Neon/border_neon_18.png",
      "assets/frames/Neon/border_neon_19.png",
      "assets/frames/Neon/border_neon_20.png",
      "assets/frames/Neon/border_neon_21.png",
      "assets/frames/Neon/border_neon_22.png",
    ],
  },
];

List stickersList = [
  {
    "category" : "Basic",
    "stickers" : [
      "assets/stickers/Basic/sticker_simple_01.png",
      "assets/stickers/Basic/sticker_simple_02.png",
      "assets/stickers/Basic/sticker_simple_03.png",
      "assets/stickers/Basic/sticker_simple_04.png",
      "assets/stickers/Basic/sticker_simple_05.png",
      "assets/stickers/Basic/sticker_simple_06.png",
      "assets/stickers/Basic/sticker_simple_07.png",
      "assets/stickers/Basic/sticker_simple_08.png",
      "assets/stickers/Basic/sticker_simple_09.png",
      "assets/stickers/Basic/sticker_simple_10.png",
      "assets/stickers/Basic/sticker_simple_11.png",
      "assets/stickers/Basic/sticker_simple_12.png",
      "assets/stickers/Basic/sticker_simple_13.png",
      "assets/stickers/Basic/sticker_simple_14.png",
      "assets/stickers/Basic/sticker_simple_15.png",
      "assets/stickers/Basic/sticker_simple_16.png",
      "assets/stickers/Basic/sticker_simple_17.png",
      "assets/stickers/Basic/sticker_simple_18.png",
      "assets/stickers/Basic/sticker_simple_19.png",
      "assets/stickers/Basic/sticker_simple_20.png",
      "assets/stickers/Basic/sticker_simple_21.png",
      "assets/stickers/Basic/sticker_simple_22.png",
      "assets/stickers/Basic/sticker_simple_23.png",
      "assets/stickers/Basic/sticker_simple_24.png",
      "assets/stickers/Basic/sticker_simple_25.png",
      "assets/stickers/Basic/sticker_simple_26.png",
      "assets/stickers/Basic/sticker_simple_27.png",
      "assets/stickers/Basic/sticker_simple_28.png",
      "assets/stickers/Basic/sticker_simple_29.png",
      "assets/stickers/Basic/sticker_simple_30.png",
    ],
  },
  {
    "category" : "Cute",
    "stickers" : [
      "assets/stickers/Cute/sticker_cute_01.png",
      "assets/stickers/Cute/sticker_cute_02.png",
      "assets/stickers/Cute/sticker_cute_03.png",
      "assets/stickers/Cute/sticker_cute_04.png",
      "assets/stickers/Cute/sticker_cute_05.png",
      "assets/stickers/Cute/sticker_cute_06.png",
      "assets/stickers/Cute/sticker_cute_07.png",
      "assets/stickers/Cute/sticker_cute_08.png",
      "assets/stickers/Cute/sticker_cute_09.png",
      "assets/stickers/Cute/sticker_cute_10.png",
      "assets/stickers/Cute/sticker_cute_11.png",
      "assets/stickers/Cute/sticker_cute_12.png",
      "assets/stickers/Cute/sticker_cute_13.png",
      "assets/stickers/Cute/sticker_cute_14.png",
      "assets/stickers/Cute/sticker_cute_15.png",
      "assets/stickers/Cute/sticker_cute_16.png",
      "assets/stickers/Cute/sticker_cute_17.png",
      "assets/stickers/Cute/sticker_cute_18.png",
      "assets/stickers/Cute/sticker_cute_19.png",
      "assets/stickers/Cute/sticker_cute_20.png",
      "assets/stickers/Cute/sticker_cute_21.png",
      "assets/stickers/Cute/sticker_cute_22.png",
      "assets/stickers/Cute/sticker_cute_23.png",
      "assets/stickers/Cute/sticker_cute_24.png",
      "assets/stickers/Cute/sticker_cute_25.png",
      "assets/stickers/Cute/sticker_cute_26.png",
      "assets/stickers/Cute/sticker_cute_27.png",
      "assets/stickers/Cute/sticker_cute_28.png",
      "assets/stickers/Cute/sticker_cute_29.png",
      "assets/stickers/Cute/sticker_cute_30.png",
      "assets/stickers/Cute/sticker_cute_31.png",
      "assets/stickers/Cute/sticker_cute_32.png",
      "assets/stickers/Cute/sticker_cute_33.png",
      "assets/stickers/Cute/sticker_cute_34.png",
      "assets/stickers/Cute/sticker_cute_35.png",
    ],
  },
  {
    "category" : "Flowers",
    "stickers" : [
      "assets/stickers/Flowers/sticker_flower_01.png",
      "assets/stickers/Flowers/sticker_flower_02.png",
      "assets/stickers/Flowers/sticker_flower_03.png",
      "assets/stickers/Flowers/sticker_flower_04.png",
      "assets/stickers/Flowers/sticker_flower_05.png",
      "assets/stickers/Flowers/sticker_flower_06.png",
      "assets/stickers/Flowers/sticker_flower_07.png",
      "assets/stickers/Flowers/sticker_flower_08.png",
      "assets/stickers/Flowers/sticker_flower_09.png",
      "assets/stickers/Flowers/sticker_flower_10.png",
      "assets/stickers/Flowers/sticker_flower_11.png",
      "assets/stickers/Flowers/sticker_flower_12.png",
      "assets/stickers/Flowers/sticker_flower_13.png",
      "assets/stickers/Flowers/sticker_flower_14.png",
      "assets/stickers/Flowers/sticker_flower_15.png",
      "assets/stickers/Flowers/sticker_flower_16.png",
      "assets/stickers/Flowers/sticker_flower_17.png",
      "assets/stickers/Flowers/sticker_flower_18.png",
      "assets/stickers/Flowers/sticker_flower_19.png",
      "assets/stickers/Flowers/sticker_flower_20.png",
      "assets/stickers/Flowers/sticker_flower_21.png",
      "assets/stickers/Flowers/sticker_flower_22.png",
      "assets/stickers/Flowers/sticker_flower_23.png",
      "assets/stickers/Flowers/sticker_flower_24.png",
      "assets/stickers/Flowers/sticker_flower_25.png",
    ],
  },
  {
    "category" : "Line Art",
    "stickers" : [
      "assets/stickers/Line Art/sticker_art_01.png",
      "assets/stickers/Line Art/sticker_art_02.png",
      "assets/stickers/Line Art/sticker_art_03.png",
      "assets/stickers/Line Art/sticker_art_04.png",
      "assets/stickers/Line Art/sticker_art_05.png",
      "assets/stickers/Line Art/sticker_art_06.png",
      "assets/stickers/Line Art/sticker_art_07.png",
      "assets/stickers/Line Art/sticker_art_08.png",
      "assets/stickers/Line Art/sticker_art_09.png",
      "assets/stickers/Line Art/sticker_art_10.png",
      "assets/stickers/Line Art/sticker_art_11.png",
    ],
  },
  {
    "category" : "Love",
    "stickers" : [
      "assets/stickers/Love/sticker_love_01.png",
      "assets/stickers/Love/sticker_love_02.png",
      "assets/stickers/Love/sticker_love_03.png",
      "assets/stickers/Love/sticker_love_04.png",
      "assets/stickers/Love/sticker_love_05.png",
      "assets/stickers/Love/sticker_love_06.png",
      "assets/stickers/Love/sticker_love_07.png",
      "assets/stickers/Love/sticker_love_08.png",
      "assets/stickers/Love/sticker_love_09.png",
      "assets/stickers/Love/sticker_love_10.png",
      "assets/stickers/Love/sticker_love_11.png",
      "assets/stickers/Love/sticker_love_12.png",
      "assets/stickers/Love/sticker_love_13.png",
      "assets/stickers/Love/sticker_love_14.png",
    ],
  },
  {
    "category" : "Pink",
    "stickers" : [
      "assets/stickers/Pink/sticker_pink_01.png",
      "assets/stickers/Pink/sticker_pink_02.png",
      "assets/stickers/Pink/sticker_pink_03.png",
      "assets/stickers/Pink/sticker_pink_04.png",
      "assets/stickers/Pink/sticker_pink_05.png",
      "assets/stickers/Pink/sticker_pink_06.png",
      "assets/stickers/Pink/sticker_pink_07.png",
      "assets/stickers/Pink/sticker_pink_08.png",
      "assets/stickers/Pink/sticker_pink_09.png",
      "assets/stickers/Pink/sticker_pink_10.png",
      "assets/stickers/Pink/sticker_pink_11.png",
      "assets/stickers/Pink/sticker_pink_12.png",
      "assets/stickers/Pink/sticker_pink_13.png",
      "assets/stickers/Pink/sticker_pink_14.png",
      "assets/stickers/Pink/sticker_pink_15.png",
      "assets/stickers/Pink/sticker_pink_16.png",
      "assets/stickers/Pink/sticker_pink_17.png",
      "assets/stickers/Pink/sticker_pink_18.png",
      "assets/stickers/Pink/sticker_pink_19.png",
      "assets/stickers/Pink/sticker_pink_20.png",
      "assets/stickers/Pink/sticker_pink_21.png",
      "assets/stickers/Pink/sticker_pink_22.png",
    ],
  },
];

List<ColorFilter> filtersList = [
  ColorFilter.mode(Colors.transparent, BlendMode.color),
  ColorFilter.linearToSrgbGamma(),
  ColorFilter.srgbToLinearGamma(),
  ColorFilter.matrix([
    -1, 0, 0, 0, 255,
    0, -1, 0, 0, 255,
    0, 0, -1, 0, 255,
    0, 0, 0, 1, 0,
  ]),
  ColorFilter.matrix([
    0.393, 0.769, 0.189, 0, 0,
    0.349, 0.686, 0.168, 0, 0,
    0.272, 0.534, 0.131, 0, 0,
    0,     0,     0,     1, 0,
  ]),
  ColorFilter.mode(Colors.grey.shade500, BlendMode.colorBurn),
  ColorFilter.mode(Colors.grey.shade800, BlendMode.colorDodge),
  ColorFilter.mode(Colors.blueGrey, BlendMode.darken),
  ColorFilter.mode(Colors.black12, BlendMode.darken),
  ColorFilter.mode(Colors.black26, BlendMode.darken),
  ColorFilter.mode(Colors.black38, BlendMode.darken),
  ColorFilter.mode(Colors.black45, BlendMode.darken),
  ColorFilter.mode(Colors.black54, BlendMode.darken),
  ColorFilter.mode(Colors.black87, BlendMode.darken),
  ColorFilter.mode(Colors.white10, BlendMode.lighten),
  ColorFilter.mode(Colors.white12, BlendMode.lighten),
  ColorFilter.mode(Colors.white24, BlendMode.lighten),
  ColorFilter.mode(Colors.white30, BlendMode.lighten),
  ColorFilter.mode(Colors.white38, BlendMode.lighten),
  ColorFilter.mode(Colors.white54, BlendMode.lighten),
  ColorFilter.mode(Colors.white60, BlendMode.lighten),
  ColorFilter.mode(Colors.white70, BlendMode.lighten),
  ColorFilter.mode(Colors.white, BlendMode.modulate),
  ColorFilter.mode(Colors.black, BlendMode.modulate),
  ColorFilter.mode(Colors.black, BlendMode.darken),
  ColorFilter.mode(Colors.white, BlendMode.lighten),
  ColorFilter.mode(Colors.red, BlendMode.multiply),
  ColorFilter.mode(Colors.blue, BlendMode.screen),
  ColorFilter.mode(Colors.green, BlendMode.color),
  ColorFilter.mode(Colors.yellow, BlendMode.hardLight),
  ColorFilter.mode(Colors.pink, BlendMode.difference),
  ColorFilter.mode(Colors.purple, BlendMode.colorBurn),
  ColorFilter.mode(Colors.orange, BlendMode.colorDodge),
  ColorFilter.mode(Colors.teal, BlendMode.exclusion),
  ColorFilter.mode(Colors.brown, BlendMode.overlay),
  ColorFilter.mode(Colors.grey, BlendMode.saturation),
  ColorFilter.mode(Colors.indigo, BlendMode.softLight),
  ColorFilter.mode(Colors.lime, BlendMode.src),
  ColorFilter.mode(Colors.amber, BlendMode.dst),
  ColorFilter.mode(Colors.cyan, BlendMode.xor),
  ColorFilter.mode(Colors.deepPurple, BlendMode.plus),
  ColorFilter.mode(Colors.deepOrange, BlendMode.modulate),
  ColorFilter.mode(Colors.lightBlue, BlendMode.screen),
  ColorFilter.mode(Colors.lightGreen, BlendMode.overlay),
  ColorFilter.mode(Colors.redAccent, BlendMode.colorDodge),
  ColorFilter.mode(Colors.blueAccent, BlendMode.darken),
  ColorFilter.mode(Colors.greenAccent, BlendMode.difference),
  ColorFilter.mode(Colors.yellowAccent, BlendMode.exclusion),
  ColorFilter.mode(Colors.pinkAccent, BlendMode.hardLight),
  ColorFilter.mode(Colors.purpleAccent, BlendMode.lighten),
  ColorFilter.mode(Colors.orangeAccent, BlendMode.multiply),
  ColorFilter.mode(Colors.tealAccent, BlendMode.overlay),
  ColorFilter.mode(Colors.black54, BlendMode.srcATop),
  ColorFilter.mode(Colors.white54, BlendMode.dstATop),
];
