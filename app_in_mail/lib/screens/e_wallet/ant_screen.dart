import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/screens/e_wallet/upgrade_prompt_box.dart';
import 'package:app_in_mail/screens/menu/menu_item_view.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AntScreen extends StatefulWidget {
  @override
  _AntScreenState createState() => _AntScreenState();
}

class _AntScreenState extends State<AntScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: UpgradePromptBox(),
        ),
        Container(
          width: 320,
          height: 200,
          decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.pink[200],
                    offset: new Offset(2, 35),
                    blurRadius: 100)
              ],
              color: AppColors.accentColor,
              borderRadius: new BorderRadius.all(Radius.circular(8))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70, left: 50),
          child: Column(
            children: <Widget>[
              MenuItemView(
                verticalPadding: 10,
                fontWeight: FontWeight.bold,
                onTap: () => () {},
                textColor: AppColors.accentColor,
                title: Localization.getString(Strings.buyAnt),
                icon: SvgPicture.asset(
                  Img.icAnt,
                  width: 22.0,
                  color: AppColors.accentColor,
                ),
              ),
              MenuItemView(
                verticalPadding: 10,
                fontWeight: FontWeight.bold,
                onTap: () => () {},
                textColor: AppColors.accentColor,
                title: Localization.getString(Strings.exchangeAntToEur),
                icon: SvgPicture.asset(
                  Img.icAnt,
                  width: 22.0,
                  color: AppColors.accentColor,
                ),
              ),
              MenuItemView(
                verticalPadding: 10,
                fontWeight: FontWeight.bold,
                onTap: () => () {},
                textColor: AppColors.accentColor,
                title: Localization.getString(Strings.transfer),
                icon: SvgPicture.asset(
                  Img.icAnt,
                  width: 22.0,
                  color: AppColors.accentColor,
                ),
              ),
              MenuItemView(
                verticalPadding: 10,
                fontWeight: FontWeight.bold,
                onTap: () => () {},
                textColor: AppColors.accentColor,
                title: Localization.getString(Strings.activity),
                icon: SvgPicture.asset(
                  Img.icAnt,
                  width: 22.0,
                  color: AppColors.accentColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}