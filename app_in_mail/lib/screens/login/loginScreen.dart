import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import "package:app_in_mail/screens/home/homePage.dart";
import 'package:app_in_mail/utils/alertHelper.dart';
import 'package:app_in_mail/screens/login/localeSelector.dart';
import 'package:app_in_mail/utils/localization.dart';

final tag = 'LoginScreen';

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
    var instanceUrl = await RestApiClient.awakeServerRuntime(userName, password)
        .catchError(_onError);
    print(instanceUrl);
    var user =
        await RestApiClient.signIn(userName, password).catchError(_onError);
    setState(() {
      this._shouldDisplayProgressIndicator = false;
    });

    Log.d("Logged in user with session:" + user.sessionId, tag);

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
    AlertHelper.showErrorMessage(
        context,
        Localization.getString(Keys.errorWhileTryingToSignIn),
        error.toString());
    Log.e('Error on login user', tag, error);
  }

  @override
  void initState() {
    super.initState();
    _emailTextController = new TextEditingController(text: '');
    _passwordTextController = new TextEditingController(text: '');

    assert(() {
      _emailTextController.text = 'p.pavlov@futurist-labs.com';
      _passwordTextController.text = '1234';
      return true;
    }());

    Localization.onLocaleChanged = () {
      setState(() {});
    };
  }

  bool _shouldDisplayProgressIndicator = false;

  Widget _getStandardBody() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 104.0, bottom: 104.0),
          child: SvgPicture.asset(
            Img.icAppMail,
            width: 173.0,
            height: 85.0,
          ),
        ),
//        Container(height: 148.0), //spacing
        Text(Localization.getString(Keys.signIn)),
        Container(
          margin: EdgeInsets.only(top: 11.0),
          width: 300.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailTextController,
            style: _tfStyle(),
            decoration: new InputDecoration(
              border: new UnderlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey),
              hintText: Localization.getString(Keys.email),
            ),
          ),
        ),
        Container(height: 11.0), //spacing
        Text(Localization.getString(Keys.password)),
        Container(height: 11.0), //spacing
        Container(
          width: 300.0,
          child: TextField(
            controller: _passwordTextController,
            style: _tfStyle(),
            obscureText: true,
            decoration: new InputDecoration(
              border: new UnderlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
//              hintStyle: new TextStyle(color: Colors.grey),
//              hintText: Localization.getString(Keys.password),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 40.0),
          width: 190.0,
          child: RaisedButton(
            child: Text(
              Localization.getString(Keys.enter),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: _onSignInPressed,
          ),
        ),
        Container(height: 20.0), //spacing
        LocaleSelector(),
      ],
    ));
  }

  TextStyle _tfStyle() => TextStyle(color: Colors.black87, fontSize: 16.0);

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
