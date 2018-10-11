//import 'package:colorize/colorize.dart';

class Log {
  ///This tags will be set allays in logs as prefix for easy sorting only app
  ///logs
  static final String appTag = 'InAppMail';
  static final String tagDebug = '👍';
  static final String tagWarning = '🤔';
  static final String tagError = '⚡';
  static final String tagInfo = '☘';

  //TODO check for pretty printing in logs
  //todo check how to apply log color

  ///This method will print developer's info in logs only if we are in debug
  ///mode
  static d(String log, [String tag]) {
    printInDebugOnly(
        tag != null ? '$tagDebug $appTag $tag' : '$tagDebug $appTag', log);
  }

  ///This method will print developer's warning logs only if we are in debug
  ///mode
  static w(String log, [String tag]) {
    printInDebugOnly(
        tag != null ? '$tagWarning $appTag $tag' : '$tagWarning $appTag', log);
  }

  static void printInDebugOnly(String tag, String log) {
    assert(() {
      _print('$tag : $log');
      return true;
    }());
  }

  static void _print(String textToLog) {
    print(textToLog);
//    Colorize string = new Colorize(textToLog);
//    string.bgGreen();
//    print(string);
  }

  ///Use this method to print in logs your error messages. Visible in production
  static e(String log, [String tag, Error error]) {
    String systemTag = '$tagError $appTag';
    if (tag != null && error != null) {
      print('$systemTag $tag : $log \n $error');
    } else if (tag != null) {
      print('$systemTag $tag : $log');
    } else if (error != null) {
      print('$systemTag : $log \n $error');
    } else {
      print('$systemTag : $log');
    }
  }

  ///Use this method to print in logs user's information messages. Visible in
  ///production
  static i(String log, [String tag]) {
    String systemTag = '$tagInfo $appTag';
    if (tag != null) {
      print('$systemTag $tag : $log');
    } else {
      print('$systemTag : $log');
    }
  }
}
