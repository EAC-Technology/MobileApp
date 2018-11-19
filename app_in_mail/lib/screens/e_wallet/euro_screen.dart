import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/model/wallet_ballance.dart';
import 'package:app_in_mail/restApi/restApiClient.dart';
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
  WalletBallance ballance;
  
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  void _loadData() async {
    RestApiClient.getWalletBallance().then((ballance){
      setState(() {
              this.ballance = ballance;
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: UpgradePromptBox(),
        ),
        CurrencyCard(
          color: Colors.white,
          shadowColor: Colors.blueGrey[100],
          valueText: '€' + this.ballance.eurBallance,
          idText: this.ballance.eurId,
          textColor: AppColors.titleTextColor,
          watermark: SvgPicture.asset(
            Img.icEuro,
            height: 180,
            color: Color.fromARGB(15, 83, 86, 120),
          ),
        ),
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
                  Img.icDepositEur,
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
                  Img.icExchangeEur,
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
                  Img.icTransfer,
                  width: 25.0,
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
                  Img.icWithfraw,
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
                  Img.icActivity,
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
