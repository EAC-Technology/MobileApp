import 'localized_strings.dart';

/// The standart flutter localization mechanisms appear to be a fragile mess of architectural brain farts.
/// To save time of my future me and my colleagues I ended up with the "simpleton" implementation bellow.
class Localization {
  static String languageCode;

  static  setLocale(String code) {
    languageCode = code;
  }

  static getText(String name) {
    return localizedStrings[languageCode][name];
  }
}