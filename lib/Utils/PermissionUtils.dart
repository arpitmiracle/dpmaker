import 'package:dpmaker/Constants/Constants.dart';
import 'package:permission_handler/permission_handler.dart';

/// this class contains permission related status granted or not.
/// it returns bool value.
/// Usage :
///   await PermissionUtils.checkStoragePermissionGranted();

class PermissionUtils {
  
  static Future checkStoragePermissionGranted()async{
    PermissionStatus _permissionGranted = await  Permission.storage.status;
    printLog("_permissionGranted $_permissionGranted");
    if (_permissionGranted != PermissionStatus.granted) {
      _permissionGranted = await Permission.storage.request();
      printLog("_permissionGranted $_permissionGranted");
      if (_permissionGranted != PermissionStatus.granted) {
        _permissionGranted = await Permission.storage.request();
        return _permissionGranted == PermissionStatus.granted;
      }
    }
    return true;
  }
}