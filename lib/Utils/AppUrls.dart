import '../Constants/Constants.dart';


///  this class contains App Urls.
///  it helps to centralize all the urls.

class AppUrls {
  static String base_url = InDevelopment ? "https://dev.miracle.com" : "https://www.miracle.com";
  static String api_base_url = "${base_url}/api/";

  static String isUserExist_url(contact){
    return "${api_base_url}is-user-exist/$contact";
  }
}