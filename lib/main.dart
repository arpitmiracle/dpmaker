import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Localization/LocalizationService.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_ad/flutter_native_ad.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Route/Routes.dart';
import 'Route/Screens.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };

  await Hive.initFlutter();
  await Hive.openBox('DpMaker');
  FlutterNativeAd.init();
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
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
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