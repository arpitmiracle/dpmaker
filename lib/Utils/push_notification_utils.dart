
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart' as dio;

class NotificationUtils {
  String userToken = "";
  bool isShow = false;

  void init() async {
    channel = const AndroidNotificationChannel(
        channelId, // id
        channelName, // title
        description: channelDes, //// description
        importance: Importance.high,
        playSound: true);

    if(!kIsWeb){
      if (Platform.isAndroid) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel)
            .then((value) {});
      } else if (Platform.isIOS) {
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
          alert: true,
          sound: true,
        )
            .then((value) {
          if (value ?? false) {}
        });
      } else {

      }

    }
    notificationConfig();
  }

  late AndroidNotificationChannel channel;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void notificationConfig() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    var token = await FirebaseMessaging.instance.getToken();
    printLog("TOKEN ========================================== $token");

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );

    onMessage();
  }

  void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification( message: message);
    });
  }

  showNotification(
      {required RemoteMessage message, }) async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentSound: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const androidSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );

    final settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: selectNotification);
    var androidPlatformChannelSpecifics = message.notification?.android?.imageUrl == null ? const AndroidNotificationDetails(
        channelId, channelName,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher',
        color: Color.fromARGB(0, 120, 120, 120),
        playSound: true) : AndroidNotificationDetails(
        channelId, channelName,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher',
        color: const Color.fromARGB(0, 120, 120, 120),
        largeIcon: ByteArrayAndroidBitmap.fromBase64String((await _downloadAndSaveFile(
          message.notification!.android!.imageUrl!,
        ))),
        styleInformation: BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String((await _downloadAndSaveFile(
            message.notification!.android!.imageUrl!,
          ))),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String((await _downloadAndSaveFile(
            message.notification!.android!.imageUrl!,
          ))),
        ),
        playSound: true);
    var iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails(presentAlert: true, presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    String? tittle = "";
    String? body = "";
    Object? notification;
    if (message.notification != null) {
      notification = message.notification;
      tittle = message.notification!.title;
      body = message.notification!.body;
    } else {
      notification = message.data;
      tittle = message.data["title"];
      body = message.data["body"];
    }

    if (notification != null) {
      if(kIsWeb){

      } else {
        if (Platform.isAndroid) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            tittle,
            body,
            platformChannelSpecifics,
            payload: jsonEncode(message.data),
          );
        }
      }
    }
    return onMessageOpenApp();
  }

  Future<String> _downloadAndSaveFile(String url) async {
    final dio.Response response = await dio.Dio(dio.BaseOptions(responseType: dio.ResponseType.bytes)).get(url);
    // final http.Response response = await http.get(Uri.parse(url),);
    return base64Encode(response.data);
  }


  void selectNotification(NotificationResponse? notificationResponse) async {
    if (notificationResponse != null) {
      if (notificationResponse.payload != null) {
        if (notificationResponse.payload!.isNotEmpty) {
          var response = json.decode(notificationResponse.payload!);
          handlePushTap(response);
        }

        if (kDebugMode) {
          print('notification payload${notificationResponse.payload}');
        }
      } else {
        if (kDebugMode) {
          print("PAYLOAD IS NULL");
        }
      }
    }
  }

  void onMessageOpenApp() {
    /// This function Manage push notification tap when app is in terminate state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handlePushTap(message.data);
      } else {
      }
    });

    /// This function Manage push notification tap when app is in background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handlePushTap(message.data);
        });
  }

  handlePushTapWithPayload(String? payLoadData) {
    if (payLoadData != null) {
      log(payLoadData.toString(), name: "myapp call");
      try {
        Map<String, dynamic> payLoad = jsonDecode(payLoadData);

        if (payLoad["type"] != null) {
          switch (payLoad["type"]) {
            case "message":
              break;
            case "newQuestion":
              break;
            default:
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("Notification Exception :-$e");
        }
      }
    }
  }

  handlePushTap(Map<String, dynamic>? payLoad) {
    if (payLoad != null) {
      // Get.toNamed(Routes.pendingQuestionScreen);
      log(payLoad.toString(), name: "myapp call");
    }
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    if (payload != null) {
      // handlePushTap(payload);
      log(payload, name: "NOTIFICATION PAYLOAD");
    } else {
      if (kDebugMode) {
        print("PAYLOAD IS NULL");
      }
    }
  }
}
