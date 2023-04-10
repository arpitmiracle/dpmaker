import 'dart:convert';
import 'package:dpmaker/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///  this class contains Localization Service make available app in multiple language.

class LocalizationService {
  /// A [LocalizationsDelegate] delegate that creates an instance of this class
  ///
  /// [locales] is the list of supported locales
  ///
  /// [dirPath] is the path where the JSON files with localizied strings are located,
  /// it's [assets/i18n] by default.
  ///
  static LocalizationsDelegate<LocalizationService> delegate(
      {List<Locale>? locales, String? dirPath}) =>
      _LocalizationServiceDelegate(locales: locales, dirPath: dirPath);

  static LocalizationService? of(BuildContext context) =>
      Localizations.of<LocalizationService>(context, LocalizationService);

  final Locale? locale;
  final String? dirPath;

  LocalizationService._({this.locale, this.dirPath = 'assets/i18n'});

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    final jsonString = await rootBundle.loadString('$dirPath/${locale!.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  /// Extracts the value out of a JSON file
  /// Requires [key] as a parameter to get the appropriate value.
  ///
  String translate(String key) => _localizedStrings[key] ?? key;
}

/// A [_LocalizationServiceDelegate] delegate extending [LocalizationsDelegate]
///
class _LocalizationServiceDelegate
    extends LocalizationsDelegate<LocalizationService> {
  const _LocalizationServiceDelegate({this.locales, this.dirPath});

  /// A list of desired localizations.
  ///
  final List<Locale>? locales;
  final String? dirPath;

  @override
  bool isSupported(Locale locale) => locales == null
      ? supportedLocales.contains(locale)
      : locales!.map((e) => e.languageCode).contains(locale.languageCode);

  @override
  Future<LocalizationService> load(Locale locale) async {
    final localizations = dirPath == null
        ? LocalizationService._(locale: locale)
        : LocalizationService._(locale: locale, dirPath: dirPath);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_LocalizationServiceDelegate old) => false;
}