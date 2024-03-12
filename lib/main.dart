import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Localization/LocalizationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_ad/flutter_native_ad.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Route/Routes.dart';
import 'Route/Screens.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('DpMaker');
  FlutterNativeAd.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation,deviceType) {
        return ValueListenableBuilder(
          valueListenable: currentAppLocal,
          builder: (BuildContext context, Locale value, Widget? child) {
            return GetMaterialApp(
              title: 'DP Creator',
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