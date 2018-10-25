import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/screens/menu/menu_item_view.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EwalletActionList extends StatefulWidget {
  @override
  _EwalletActionListState createState() => _EwalletActionListState();
}

class _EwalletActionListState extends State<EwalletActionList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MenuItemView(
          textColor: AppColors.accentColor,
          title: Localization.getString(Strings.exchange),
          icon: SvgPicture.asset(
            Img.icExchange,
            width: 24.0,
          ),
        ),
        MenuItemView(
          textColor: Colors.white,
          title: Localization.getString(Strings.euroWallet),
          icon: SvgPicture.asset(
            Img.icEuro,
            width: 16.0,
          ),
        ),
        MenuItemView(
          textColor: Colors.white,
          title: Localization.getString(Strings.antWallet),
          icon: SvgPicture.asset(
            Img.icAnt,
            width: 22.0,
          ),
        ),
        MenuItemView(
          textColor: Colors.white,
          title: Localization.getString(Strings.realTimeChart),
          icon: SvgPicture.asset(
            Img.icChart,
            width: 28.0,
          ),
        ),
        MenuItemView(
          textColor: Colors.white,
          title: Localization.getString(Strings.upgradeToStandard),
          icon: SvgPicture.asset(
            Img.icUpgrade,
            width: 18.0,
          ),
        ),
      ],
    );
  }
}
