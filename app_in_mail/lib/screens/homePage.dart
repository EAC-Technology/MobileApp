import 'package:flutter/material.dart';
import './loginScreen.dart';
import './sideDrawer.dart';
import './emailList.dart';
import '../restApi/restApiClient.dart';
import 'package:app_in_mail/translations.dart';

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
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: SideDrawer(),
        appBar: new AppBar(
          title: new Text(Translations.of(context).text('main_title')),
        ),
        body: EmailList());
  }
}
