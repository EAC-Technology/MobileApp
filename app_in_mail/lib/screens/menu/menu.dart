import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
import 'package:app_in_mail/screens/login/loginScreen.dart';
import 'package:app_in_mail/screens/menu/ewallet_action_list.dart';
import 'package:app_in_mail/screens/menu/folder_list_view.dart';
import 'package:app_in_mail/screens/menu/info_action_list.dart';
import 'package:app_in_mail/screens/menu/menu_button.dart';
import 'package:app_in_mail/screens/settings/settigs_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum MenuMode { email, wallet, settings, info }

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  MenuMode mode = MenuMode.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkBackground,
          elevation: 0,
        ),
        backgroundColor: AppColors.darkBackground,
        body: Column(
          children: <Widget>[
            Container(
              child: _buildHeader(context),
            ),
            Container(
              height: 60,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  _buildLeftButtonColumn(),
                  Container(
                    width: 0.5,
                    color: AppColors.greyLight,
                  ),
                  Expanded(
                    child: _getMenuBody(),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.all(const Radius.circular(7.0)),
                  child: Image.asset(
                    'assets/avatar.png',
                    width: 43.0,
                    height: 43.0,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'FirstName \nLastName',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: SvgPicture.asset(
                Img.icLogout,
                width: 25.0,
                color: AppColors.accentColor,
              ),
              onPressed: () {
                _onLogoutPressed();
              },
            ),
          ),
        ],
      ),
    );
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

  Widget _getMenuBody() {
    switch (this.mode) {
      case MenuMode.email:
        return FolderListView();
      case MenuMode.wallet:
        return EwalletActionList();
      case MenuMode.settings:
        return Container();
      case MenuMode.info:
        return InfoActionList();
    }

    return Container();
  }

  Container _buildLeftButtonColumn() {
    return Container(
      // Left Column with buttons, settings etc.
      width: 90,
      child: Column(
        children: <Widget>[
          MenuButton(
            onTap: () {
              setState(() {
                this.mode = MenuMode.email;
              });
            },
            hasNewItems: true,
            isSelected: this.mode == MenuMode.email,
            color: AppColors.accentColor,
            child: Text(
              '754',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ), //Todo: replace hardcoded count
          Container(
            height: 40,
          ), //spacing
          MenuButton(
            onTap: () {
              setState(() {
                this.mode = MenuMode.wallet;
              });
            },
            isSelected: this.mode == MenuMode.wallet,
            color: AppColors.eWalletButtonBackground,
            child: Text(
              'eW',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            height: 40,
          ), //spacing
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              setState(() {
                this.mode = MenuMode.settings;
                _navigateToSetttings();
              });
            },
          ),
          Container(
            height: 40,
          ),
          IconButton(
            icon: SvgPicture.asset(
              Img.icInfo,
              width: 26.0,
            ),
            color: Colors.white,
            onPressed: () {
              setState(() {
                this.mode = MenuMode.info;
              });
            },
          )
        ],
      ),
    );
  }

  void _navigateToSetttings() {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new SettingsScreen();
        },
      ),
    );
  }
}
