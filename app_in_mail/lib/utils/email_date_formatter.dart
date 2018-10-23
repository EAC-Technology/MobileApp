import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class EmailDateFormatter {
  static String formatDate(DateTime emailDateTime) {
    var delta = DateTime.now().difference(emailDateTime);

    if (delta.inDays < 1) { // if emails is from today
       var formatter = new DateFormat.Hm();
      return formatter.format(emailDateTime);
    } else if (delta.inDays < 7) { // if email is from this week
        return timeago.format(emailDateTime);
    } else if (delta.inDays < 365) { //if email is from this year
        var formatter = new DateFormat.MEd();
        return formatter.format(emailDateTime);
    } else { //if email is ancient
        var formatter = new DateFormat.yM();
        return formatter.format(emailDateTime);
    }
  }
}

//TODO test and validate with french locales.