import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/screens/menu/ewalet_action_list.dart';
import 'package:app_in_mail/screens/menu/folder_list_view.dart';
import 'package:app_in_mail/screens/menu/menu_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum MenuMode { email, wallet }

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  MenuMode mode = MenuMode.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Column(
          children: <Widget>[
            Container(
              //todo: place the profile widget here once ready.
              height: 160,
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
                    child: this.mode == MenuMode.email
                        ? Container(child: FolderListView())
                        : Container(child: EwalletActionList()),
                  )
                ],
              ),
            )
          ],
        ));
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
            onPressed: () {},
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
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
