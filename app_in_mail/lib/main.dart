import 'package:flutter/material.dart';
import 'screens/homePage.dart';
import 'package:flutter/services.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MaterialApp(
      home: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
