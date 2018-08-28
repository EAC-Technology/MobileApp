import 'localized_strings.dart';
import 'dart:ui';

/// The standart flutter localization mechanisms appear to be a fragile mess of architectural brain farts.
/// To save time of my future me and my colleagues I ended up with the "simpleton" implementation bellow.
class Localization {
  static String languageCode;
  static VoidCallback onLocaleChanged;
  static setLocale(String code) {
    languageCode = code;
    if ( onLocaleChanged != null) {
      onLocaleChanged();
    }
  }

  static List<String> get supportedLocales {
    final result = localizedStrings.keys.toList(); 
    return  result;
  }

  static getText(String name) {
    return localizedStrings[languageCode][name];
  }
}