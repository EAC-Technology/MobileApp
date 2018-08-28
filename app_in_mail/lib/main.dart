import 'package:flutter/material.dart';
import 'screens/homePage.dart';
import 'package:flutter/services.dart';
import 'package:app_in_mail/localization.dart';

import 'dart:async';
import 'dart:io';
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

      final snackBar = SnackBar(content: Text('got uri: ${uri?.path} ${uri?.queryParametersAll}'));


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
    
    final appInmailLogoColor = Color.fromRGBO(218, 34, 80, 1.0);
    return new MaterialApp(
      title: 'AppInMail',
      theme: new ThemeData(
          textSelectionHandleColor: Colors.white,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            minWidth: 300.0,
            height: 44.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(const Radius.circular(8.0))),
          ),
          cursorColor: Colors.white,
          accentColor: Colors.white,
          dividerColor: Colors.white,
          hintColor: Color.fromRGBO(255, 255, 255, 0.5),
          highlightColor: Colors.white,
          buttonColor: appInmailLogoColor,
          primaryColor: appInmailLogoColor,
          textSelectionColor: appInmailLogoColor,
          textTheme: TextTheme(
              headline: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          scaffoldBackgroundColor: Color.fromRGBO(57, 60, 73, 1.0)),
      home: new HomePage(),
    );
  }
}
 

