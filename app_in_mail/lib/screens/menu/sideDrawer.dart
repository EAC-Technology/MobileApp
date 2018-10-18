import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:flutter/material.dart';
import 'package:app_in_mail/screens/login/loginScreen.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
class SideDrawer extends StatefulWidget {
  SideDrawer({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SideDrawerState createState() => new SideDrawerState();
}

class SideDrawerState extends State<SideDrawer> {
  String _userName;
  
  @override
  void initState() {
    super.initState();
    _userName = "";
    final user = RestApiClient.signedInUser;
    if (user != null) {
      _userName = user.firstName + " " + user.lastName;
    }
  }
  void _onLogoutPressed() {
    RestApiClient.logOut();
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new LoginScreen();
        },
      ),
    );


  }

  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(57, 60, 73, 1.0),
              width: 80.0,
              child: Column(
                children: <Widget>[
                  Container(height: 60.0), //spacing
                  Image.asset('assets/logo.png'),
                ],
              ),
            ),
            Expanded(child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(height: 60.0), //spacing
                  ClipRRect(
                      borderRadius:  BorderRadius.all(
                      const Radius.circular(20.0)),
                      child: Image.asset(
                    'assets/avatar.png',
                    width: 100.0,
                  )),
                  Container(height: 10.0), //Spacer
                  Text(_userName,
                   style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(height: 10.0), //Spacer //Name
                  Text('Country'), //Name
                  Container(height: 10.0), //Spacer //Name
                  Container(height: 1.0,  color: Colors.grey, width: 200.0,),//Separator
                  FlatButton(child: Text(Localization.getString(Strings.logout)), onPressed: _onLogoutPressed,)
                ],
              ),
            ),
          ),
            ],
        ),
      ),
    );
  }
}
