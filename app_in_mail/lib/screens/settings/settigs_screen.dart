import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/screens/menu/menu.dart';
import 'package:app_in_mail/screens/menu/menu_item_view.dart';
import 'package:app_in_mail/screens/settings/edit_personal_data_form.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    void _navigateToMenu() {
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return new Menu();
          },
        ),
      );
    }

    void _navigateToPersonalData() {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return new EditPersonalDataForm();
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0, //removing the shadow to fit the design
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.clear,
              size: 28,
            ),
            onPressed: () {
              _navigateToMenu();
            },
          )
        ],
        backgroundColor: AppColors.darkBackground,
      ),
      backgroundColor: AppColors.darkBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              MenuItemView(
                title: Localization.getString(Strings.blockedAccount),
                icon: SvgPicture.asset(
                  Img.icBlocked,
                  width: 20.0,
                ),
              ),
              MenuItemView(
                onTap: () => _navigateToPersonalData(),
                textColor: Colors.white,
                title: Localization.getString(Strings.editPersonalData),
                icon: SvgPicture.asset(
                  Img.icEdit,
                  width: 22.0,
                ),
              ),
              MenuItemView(
                textColor: AppColors.accentColor,
                title: Localization.getString(Strings.delete),
                icon: SvgPicture.asset(
                  Img.icDelete,
                  width: 20.0,
                ),
              ),
            ],
          ),
          Padding(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                Container(
                  width: 20,
                ),
                Text(
                  'account identificator guid to be placed here',
                  style: TextStyle(color: AppColors.greyLight),
                )
              ],
            ),
            padding: EdgeInsets.all(30),
          ),
        ],
      ),
    );
  }
}
