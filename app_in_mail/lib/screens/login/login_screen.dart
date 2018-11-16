import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/custom_widgets/appinmail_textfield.dart';
import 'package:app_in_mail/custom_widgets/flat_ripple_button.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/login/locale_selector.dart';
import 'package:app_in_mail/screens/welcome_page.dart';
import 'package:app_in_mail/utils/alert_helper.dart';
import 'package:app_in_mail/utils/config.dart';
import 'package:app_in_mail/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  Future<bool> _rememberMe;
  bool rememberMe = false;

  void _storeCredentials() {
    final secureStorage = new FlutterSecureStorage();
    secureStorage.write(key: 'username', value: _emailTextController.text);
    secureStorage.write(key: 'password', value: _passwordTextController.text);
  }

  void _onSignInPressed() async {
    final userName = _emailTextController.text;
    final password = _passwordTextController.text;
//    todo validate fields first
    setState(() {
      this._shouldDisplayProgressIndicator = true;
    });
    var instanceUrl = await RestApiClient.awakeServerRuntime(userName, password)
        .catchError(_onError);
    print(instanceUrl);
    var user = await RestApiClient.signIntoEmail(userName, password)
        .catchError(_onError);

    var result =
        await RestApiClient.testAntAPI(userName, password).catchError(_onError);
//    setState(() {
//      this._shouldDisplayProgressIndicator = false;
//    });

    Log.d("Logged in user with session:" + user.sessionId, tag);

    final SharedPreferences preferences = await _sharedPreferences;
    bool rememberMe = preferences.getBool('rememberMe');

    if (rememberMe) {
      _storeCredentials();
    }

    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
//          todo Check if welcome page has been seen already, if not redirect
// to it else go Home
          return new WelcomePage(); //new HomePage();
        },
      ),
    );
  }

  void _onError(error) {
    if (!this.mounted) return;

    setState(() {
      _shouldDisplayProgressIndicator = false;
    });
    AlertHelper.showErrorMessage(
        context,
        Localization.getString(Strings.errorWhileTryingToSignIn),
        error.toString());
    Log.e('Error on login user', tag, error);
  }

  @override
  void initState() {
    super.initState();
    _emailTextController = new TextEditingController(text: '');
    _passwordTextController = new TextEditingController(text: '');

    _rememberMe = _sharedPreferences.then((SharedPreferences prefs) {
      return (prefs.getBool('rememberMe') ?? false);
    });

    final secureStorage = new FlutterSecureStorage();
    secureStorage.read(key: 'username').then((value) {
      setState(() {
        _emailTextController.text = value;
      });
    });

    secureStorage.read(key: 'password').then((value) {
      setState(() {
        _passwordTextController.text = value;
      });
    });

    Localization.onLocaleChanged = () {
      if (!this.mounted) return;
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Center(
        child: _getBody(),
      ),
    );
  }

  bool _shouldDisplayProgressIndicator = false;
  double _textFieldWidth = 300.0, _textFieldMargin = 11.0;

  Widget _getStandardBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          Img.icAppMailSvg,
          width: 173.0,
          height: 85.0,
        ),
        _formSection(),
        _extraOptionSection()
      ],
//    )
    );
  }

  Column _extraOptionSection() {
    return Column(
      children: <Widget>[
        LocaleSelector(),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: _registerRow(),
        ),
        Container(
          margin: EdgeInsets.only(top: 16.0),
          child: FlatAppButton(
              Strings.forgotPasswordBtn,
              (contextFromButton) =>
                  AlertHelper.showSnackBar(contextFromButton, "TBI")),
        ),
      ],
    );
  }

  void _onRememberMeChanged(bool shallRememberCredentials) async {
    final SharedPreferences preferences = await _sharedPreferences;
    final secureStorage = new FlutterSecureStorage();

    if (!shallRememberCredentials) {
      secureStorage.delete(key: 'username');
      secureStorage.delete(key: 'password');
    }

    setState(() {
      preferences.setBool('rememberMe', shallRememberCredentials);
    });
  }

  Column _formSection() {
    return Column(
      children: <Widget>[
        Text(Localization.getString(Strings.signIn)),
        Container(
            margin: EdgeInsets.only(
                top: _textFieldMargin, bottom: _textFieldMargin),
            width: _textFieldWidth,
            child: AppInMailTextField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress)),
        Text(Localization.getString(Strings.password)),
        Container(
            margin: EdgeInsets.only(top: _textFieldMargin),
            width: _textFieldWidth,
            child: AppInMailTextField(
                controller: _passwordTextController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 280,
            child: Row(
              children: <Widget>[
                Text(Localization.getString(Strings.rememberMe)),
                FutureBuilder(
                  future: _rememberMe,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return Switch(
                      onChanged: (bool value) {
                        this._onRememberMeChanged(value);
                      },
                      value: snapshot.data,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          width: 190.0,
          child: RaisedButton(
            child: Text(
              Localization.getString(Strings.enter),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: _onSignInPressed,
          ),
        ),
      ],
    );
  }

  Row _registerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          Localization.getString(Strings.registerMsg),
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 13.0,
              color: Colors.black),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FlatAppButton(
                Strings.registerBtn,
                (contextFromButton) =>
                    AlertHelper.showSnackBar(contextFromButton, "TBI")))
      ],
    );
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
}
