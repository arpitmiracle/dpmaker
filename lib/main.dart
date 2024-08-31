import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Localization/LocalizationService.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_ad/flutter_native_ad.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Route/Routes.dart';
import 'Route/Screens.dart';
import 'Utils/circular_text.dart';
import 'Utils/push_notification_utils.dart';
import 'firebase_options.dart';

const String channelId = "dp_creator_channel";
const String channelName = "Dp Creator";
const String channelDes = "Dp Creator - ProfilePic Master";

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  await Hive.openBox('DpMaker');
  NotificationUtils notificationUtils = NotificationUtils();
  notificationUtils.init();
  FlutterNativeAd.init(testDeviceIds: ["AD407A3057F93CDF73BC44084C712E6A"]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation,deviceType) {
        return ValueListenableBuilder(
          valueListenable: currentAppLocal,
          builder: (BuildContext context, Locale value, Widget? child) {
            return GetMaterialApp(
              title: 'DP Creator - ProfilePic Master',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: CustomColors.swatch,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: Theme.of(context).textTheme,
              ),
              builder: (context, child) {
                //to remove shadow(glow) while scrolling
                return ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: child!,
                );
              },
              navigatorObservers: <NavigatorObserver>[observer],
              routes: Screens.screens,
              initialRoute: Routes.homeScreen,
              supportedLocales: supportedLocales,
              locale: value,
              localizationsDelegates: [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                LocalizationService.delegate()
              ],
              // to determine whether or not the user’s device locale is supported by our app
              localeResolutionCallback: (Locale? userLocale, Iterable < Locale > supportedLocales) {
                for (var locale in supportedLocales) {
                  if (locale.languageCode == userLocale?.languageCode &&
                      locale.countryCode == userLocale?.countryCode) {
                    return userLocale;
                  }
                }
                return supportedLocales.first;
              },
            );
          }
        );
      }
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}