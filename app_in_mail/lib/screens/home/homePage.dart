import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/login/loginScreen.dart';
import 'package:app_in_mail/screens/menu/sideDrawer.dart';
import 'package:app_in_mail/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:app_in_mail/screens/home/emailList.dart';
import 'package:app_in_mail/utils/localization.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (RestApiClient.needsLogin()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToLogin());
    }
  }

  void _navigateToLogin() {
    Log.d("no saved user, redirect to Login screen");
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new LoginScreen();
        },
      ),
    );
  }

  //todo change the SideDrawer to single page
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: SideDrawer(),
        appBar: !RestApiClient.needsLogin()
            ? new AppBar(
                title: new Text(Localization.getString(Strings.inbox)),
              )
            : null,
        body: EmailList());
  }
}
