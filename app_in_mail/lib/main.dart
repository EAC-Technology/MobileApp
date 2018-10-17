import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:app_in_mail/screens/home/homePage.dart';
import 'package:flutter/services.dart';
import 'package:app_in_mail/utils/localization.dart';

import 'dart:async';
import 'package:uni_links/uni_links.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MaterialApp(
      home: MyApp(),
    ));
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: unused_field
  Uri _latestUri;
  String _latestLink = 'Unknown';
  StreamSubscription _sub;

  /// An implementation using the [Uri] convenience helpers
  initPlatformStateForUriUniLinks() async {
    // Attach a listener to the Uri links stream
    _sub = getUriLinksStream().listen((Uri uri) {
      if (!mounted) return;
      setState(() {
        _latestUri = uri;
        _latestLink = uri?.toString() ?? 'Unknown';
        print(_latestLink);
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestUri = null;
        _latestLink = 'Failed to get latest link: $err.';
      });
    });

    // Attach a second listener to the stream
    getUriLinksStream().listen((Uri uri) {
      print('got uri: ${uri?.path} ${uri?.queryParametersAll}');

      final snackBar = SnackBar(
          content: Text('got uri: ${uri?.path} ${uri?.queryParametersAll}'));

      Scaffold.of(context).showSnackBar(snackBar);
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest Uri
    Uri initialUri;
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialUri = await getInitialUri();
      print('initial uri: ${initialUri?.path}'
          ' ${initialUri?.queryParametersAll}');
      initialLink = initialUri?.toString();
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestUri = initialUri;
      _latestLink = initialLink;
    });
  }

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await initPlatformStateForUriUniLinks();
  }

  @override
  dispose() {
    if (_sub != null) _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    Localization.setLocale(locale.languageCode);

    final appInMailLogoColor = AppColors.accentColor;
    return new MaterialApp(
      title: 'AppInMail',
      theme: new ThemeData(
          fontFamily: Constants.mainFont,
          textSelectionHandleColor: Colors.white,
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFFF33E7D),
            textTheme: ButtonTextTheme.primary,
            minWidth: 300.0,
            height: 44.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(const Radius.circular(8.0))),
          ),
//          cursorColor: Colors.white,
          accentColor: appInMailLogoColor,
          dividerColor: Colors.white,
          hintColor: Color.fromRGBO(255, 255, 255, 0.5),
          highlightColor: Colors.white,
          buttonColor: Color(0xFFF33E7D),
          primaryColor: appInMailLogoColor,
          textSelectionColor: appInMailLogoColor,
          textTheme: TextTheme(
              body1: TextStyle(
                  color: Color(0xFFF33E7D),
                  fontSize: 13.0,
                  fontWeight: FontWeight.normal),
              headline: TextStyle(
                  color: Color(0xF33E7D),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          scaffoldBackgroundColor: Colors.white),
      home: //new WelcomePage(),
              new HomePage(),
    );
  }
}
