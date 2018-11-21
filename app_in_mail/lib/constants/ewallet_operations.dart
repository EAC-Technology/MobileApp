import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/utils/localization.dart';

class EwalletOperations {
  //Eur
  static final depositEur = {
    'operation': 'deposit',
    'title': Localization.getString(Strings.depositEur)
  };
  static final exchangeEur = {
    'operation': 'exchange',
    'title': Localization.getString(Strings.exchangeEurToAnt)
  };
  static final transferEur = {
    'operation': 'transfer',
    'title': Localization.getString(Strings.transfer)
  };
  static final withdrawEur = {
    'operation': 'withdraw',
    'title': Localization.getString(Strings.withdraw)
  };

  //Ant
  static final buyAnt = {
    'operation': 'buy',
    'title': Localization.getString(Strings.buyAnt)
  };
  static final exchangeAnt = {
    'operation': 'sell',
    'title': Localization.getString(Strings.exchangeAntToEur)
  };
  static final transferAnt = {
    'operation': 'send',
    'title': Localization.getString(Strings.transfer)
  };

  //TODO: Activity - ask Nicolas
}
