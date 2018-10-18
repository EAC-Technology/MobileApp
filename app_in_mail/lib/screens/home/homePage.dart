import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/login/loginScreen.dart';
import 'package:app_in_mail/screens/menu/sideDrawer.dart';
import 'package:app_in_mail/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:app_in_mail/screens/home/emailList.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearchCollapsed = true;

  @override
  void initState() {
    super.initState();
    if (RestApiClient.needsLogin()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToLogin());
    }
  }

  //todo change the SideDrawer to single page
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: SideDrawer(),
        appBar: !RestApiClient.needsLogin() ? buildAppBar() : null,
        body: EmailList(
          isSearchCollapsed: this._isSearchCollapsed,
        ));
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

  AppBar buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        Localization.getString(Strings.inbox),
        style: TextStyle(
            color: AppColors.titleTextColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      leading: Builder(
        builder: (context) {
          return IconButton(
              icon: SvgPicture.asset(
                Img.icMenu,
                width: 22.0,
                height: 18.0,
              ),
              onPressed: () => Scaffold.of(context).openDrawer());
        },
      ),
      actions: <Widget>[
        InkWell(
          child: Row(
            children: <Widget>[
              new Text(
                "1", //todo use new emails count
                style: TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SvgPicture.asset(
                  Img.icDot,
                  width: 8.0,
                  height: 8.0,
                ),
              ),
            ],
          ),
        ),
        IconButton(
            icon: SvgPicture.asset(
              Img.icSearch,
              width: 18.0,
              height: 18.0,
            ),
            onPressed: () {
              setState(() {
                _isSearchCollapsed = !_isSearchCollapsed;
              });
            }),
      ],
    );
  }
}
