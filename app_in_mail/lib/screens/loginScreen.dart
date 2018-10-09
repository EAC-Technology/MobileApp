import 'package:flutter/material.dart';
import '../restApi/restApiClient.dart';
import "homePage.dart";
import 'alertHelper.dart';
import 'localeSelector.dart';
import 'package:app_in_mail/localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;
  void _onSignInPressed() async {
    final userName = _emailTextController.text;
    final password = _passwordTextController.text;
    setState(() {
      this._shouldDisplayProgressIndicator = true;
    });
    var instanceUrl =
        await RestApiClient.awakeServerRuntime(userName, password).catchError(_onError);
    print(instanceUrl);
    var user =
        await RestApiClient.signIn(userName, password).catchError(_onError);
    setState(() {
      this._shouldDisplayProgressIndicator = false;
    });

    print("Logged in user with session:" + user.sessionId);
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new HomePage();
        },
      ),
    );
  }

  void _onError(error) {
    setState(() {
      _shouldDisplayProgressIndicator = false;
    });
    AlertHelper.showErrorMessage(context, Localization.getText('error_while_trying_to_sign_in'), error.toString());
  }

  @override
  void initState() {
    super.initState();
    _emailTextController =
        new TextEditingController(text: '');
    _passwordTextController = new TextEditingController(text: '');
    Localization.onLocaleChanged = (){
      setState(() {
    });
    };
  }

  bool _shouldDisplayProgressIndicator = false;
  Widget _getStandardBody() {
    
    return SingleChildScrollView(child: Column(
      children: <Widget>[
        SvgPicture.asset('assets/appinmail_logo.svg', width: 173.0, height: 85.0,), 
        Container(height: 148.0), //spacing
        Text(Localization.getText('signin')), 
        Container(height: 11.0), //spacing
        Container(
          width: 300.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailTextController,
            style: TextStyle(color: Colors.black87),
            decoration: new InputDecoration(
              border: new UnderlineInputBorder (
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey),
              hintText: Localization.getText('email'),
            ),
          ),
        ),
        Container(height: 20.0), //spacing
        Container(
          width: 300.0,
          child: TextField(
            controller: _passwordTextController,
            style: TextStyle(color: Colors.white),
            obscureText: true,
            decoration: new InputDecoration(
              border: new UnderlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey),
              hintText: Localization.getText('password'),
            ),
          ),
        ),
        Container(height: 20.0), //spacing

        Container(height: 20.0), //spacing
        RaisedButton(
          child: Text(
            Localization.getText('enter'),
            style: TextStyle( 
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          onPressed: _onSignInPressed,
        ),
        Container(height: 20.0), //spacing
        LocaleSelector(
        ),

      ],
    ));

  }

  Widget _getProgressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getBody() {
    if (_shouldDisplayProgressIndicator) {
      return _getProgressIndicator();
    } else {
      return _getStandardBody();
    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      
      body: new Center(
        child: _getBody(),
      ),
    );
  }
}
