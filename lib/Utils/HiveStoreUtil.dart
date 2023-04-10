import 'package:hive_flutter/hive_flutter.dart';

///  this class contains HiveStore communication.
///  it contains getter and setter function and also all storage keys.
///  because it helps to centralize all the storage related keys.

class HiveStoreUtil {
  static String storageKey = "storageKey";
  static String noInternetListKey = "noInternetListKey";
  static var hiveBox = Hive.box('Demo');

  static void setString(String key,String value){
    hiveBox.put(key, value);
  }

  static String getString(String key){
    return hiveBox.get(key,defaultValue: "");
  }

  static void setInt(String key,int value){
    hiveBox.put(key, value);
  }

  static int getInt(String key){
    return hiveBox.get(key,defaultValue: 0);
  }

  static void setBool(String key,bool value){
    hiveBox.put(key, value);
  }

  static bool getBool(String key){
    return hiveBox.get(key,defaultValue: false);
  }

  static void setList(String key,List value){
    hiveBox.put(key, value);
  }

  static List getList(String key){
    return hiveBox.get(key,defaultValue: []);
  }

}