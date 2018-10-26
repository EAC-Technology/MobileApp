import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/screens/e_wallet/currency_card.dart';
import 'package:app_in_mail/screens/e_wallet/upgrade_prompt_box.dart';
import 'package:app_in_mail/screens/menu/menu_item_view.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EuroScreen extends StatefulWidget {
  @override
  _EuroScreenState createState() => _EuroScreenState();
}

class _EuroScreenState extends State<EuroScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: UpgradePromptBox(),
        ),
        new CurrencyCard(),
        Padding(
          padding: const EdgeInsets.only(top: 70, left: 50),
          child: Column(
            children: <Widget>[
              MenuItemView(
                verticalPadding: 15,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                onTap: () => () {},
                textColor: AppColors.accentColor,
                title: Localization.getString(Strings.depositEur),
                icon: SvgPicture.asset(
                  Img.icAnt,
                  width: 22.0,
                  color: AppColors.accentColor,
                ),
              ),
              MenuItemView(
                verticalPadding: 15,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                onTap: () => () {},
                textColor: AppColors.accentColor,
                title: Localization.getString(Strings.exchangeEurToAnt),
                icon: SvgPicture.asset(
                  Img.icAnt,
                  width: 22.0,
                  color: AppColors.accentColor,
                ),
              ),
              MenuItemView(
                verticalPadding: 15,
                fontSize: 17,
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
                verticalPadding: 15,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                onTap: () => () {},
                textColor: AppColors.accentColor,
                title: Localization.getString(Strings.withdraw),
                icon: SvgPicture.asset(
                  Img.icAnt,
                  width: 22.0,
                  color: AppColors.accentColor,
                ),
              ),
              MenuItemView(
                verticalPadding: 15,
                fontSize: 17,
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

