import 'package:flutter/material.dart';
import '../restApi/restApiClient.dart';
import "homePage.dart";
import 'alertHelper.dart';
import 'package:intl/intl.dart';

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
    AlertHelper.showErrorMessage(context, 'Error while trying to sign in', error.toString());
  }

  @override
  void initState() {
    super.initState();
    _emailTextController =
        new TextEditingController(text: "p.pavlov@futurist-labs.com");
    _passwordTextController = new TextEditingController(text: "1234");
  }

  bool _shouldDisplayProgressIndicator = false;
  Widget _getStandardBody() {
    return Column(
      children: <Widget>[
        Container(height: 20.0), //spacing
        Image.asset('assets/logo.png'),
        Container(height: 40.0), //spacing
        Text('Sign In', style: Theme.of(context).textTheme.headline),
        Container(height: 40.0), //spacing
        Container(
          width: 300.0,
          child: TextField(
            controller: _emailTextController,
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey),
              hintText: "E-mail",
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
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey),
              hintText: "Password",
            ),
          ),
        ),
        Container(height: 20.0), //spacing

        Container(height: 20.0), //spacing
        RaisedButton(
          child: Text(
            Intl.message('Enter', name: 'enter'),
            style: TextStyle( 
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          onPressed: _onSignInPressed,
        ),
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

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Center(
        child: _getBody(),
      ),
    );
  }
}
