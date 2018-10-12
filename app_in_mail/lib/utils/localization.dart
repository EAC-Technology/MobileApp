import 'package:app_in_mail/constants/strings/en_strings.dart';
import 'package:app_in_mail/constants/strings/fr_strings.dart';
import 'package:app_in_mail/utils/logger.dart';

import 'localized_strings.dart';
import 'dart:ui';

/// The standart flutter localization mechanisms appear to be a fragile mess of architectural brain farts.
/// To save time of my future me and my colleagues I ended up with the "simpleton" implementation bellow.
class Localization {
  static String languageCode;
  static VoidCallback onLocaleChanged;
  static Map<String,String> _strings;

  static setLocale(String code) {
    if (supportedLocales.contains(code)) {
      languageCode = code;
    } else {
      languageCode = 'en'; //non supported locales default to en.
    }

    switch (languageCode) {
      case 'fr':
        _strings = localizedStringsFr;
        break;
      default:// english string for default
        _strings = localizedStringsEn;
    }
    if (onLocaleChanged != null) {
      onLocaleChanged();
    }
  }

  static List<String> get supportedLocales {
//    final result = localizedStrings.keys.toList();
    return ['en', 'fr'];
  }

  ///we'll keep this until all text is replaced in the app
  @deprecated
  static getText(String name) {
    return localizedStrings[languageCode][name];
  }

  ///Use for key parameter one out of Keys class
  ///
  ///import 'package:app_in_mail/constants/strings/string_keys.dart';
  static String getString(String key) {
    String textToReturn = _strings[key];
    if(textToReturn == null){
      Log.e("No text for id : $key");
      textToReturn = 'no text';
    }
    return textToReturn;
  }
}
