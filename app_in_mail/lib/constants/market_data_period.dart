import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/utils/localization.dart';

class MarketDataPeriods {
  static final twelveHours = '12HOURS';
  static final twentyFourHours = '24HOURS';
  static final sevenDays = '7DAYS';
  static final twoWeeks = '2WEEKS';
  static final oneMonth = '1MONTH';
  static final sixMonths = '6MONTH';
  static final oneYear = '1YEAR';

  static final values = [twelveHours, twentyFourHours, sevenDays, twoWeeks, oneMonth, sixMonths, oneYear];
  static final displayValues = [
    Localization.getString(Strings.twelveHours),
    Localization.getString(Strings.twentyFourHours),
    Localization.getString(Strings.sevenDays),
    Localization.getString(Strings.twoWeeks),
    Localization.getString(Strings.oneMonth),
    Localization.getString(Strings.sixMonths),
    Localization.getString(Strings.oneYear),
  ];
}


