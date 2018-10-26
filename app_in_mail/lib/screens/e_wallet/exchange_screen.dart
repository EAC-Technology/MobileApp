import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/screens/e_wallet/currency_card.dart';
import 'package:app_in_mail/screens/menu/menu.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.eWalletBackground,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: Center(
                  child: Text(
                Localization.getString(Strings.exchange),
                style: TextStyle(color: AppColors.titleTextColor, fontSize: 34),
              )),
            ),
            CurrencyCard(
              icon: SvgPicture.asset(
                Img.icEuro,
                width: 16.0,
                color: AppColors.titleTextColor,
              ),
              valueColor: AppColors.titleTextColor,
              text: '100000',
              title: Localization.getString(Strings.youHave),
            ),
            CurrencyCard(
              icon: SvgPicture.asset(
                Img.icAnt,
                width: 24.0,
                color: AppColors.accentColor,
              ),
              text: '2.001',
              valueColor: AppColors.accentColor,
              title: Localization.getString(Strings.youGet),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                  child: RaisedButton(
                onPressed: () {},
                child: Container(
                  width: 200,
                  child: Center(
                    child: Text(
                      Localization.getString(Strings.exchange).toUpperCase(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              child: Container(
                width: 250,
                child: Row(
                  children: <Widget>[
                    Text(
                      Localization.getString(Strings.exchangeEuroWith),
                      style: TextStyle(
                          color: AppColors.titleTextColor, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(Img.logoVisa),
                  Image.asset(Img.logoeWallet),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: 250,
                child: Row(
                  children: <Widget>[
                    Image.asset(Img.logoBankTransfer),
                  ],
                ),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              height: 210,
            ),
            Center(
              child: Container(
                width: 350,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      Img.icSwitch,
                      width: 30.0,
                      color: AppColors.titleTextColor,
                    ),
                    onPressed: () {
                      //Todo switch boxes here
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        'eWallet',
        style: TextStyle(
            color: AppColors.titleTextColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.0,
      leading: Builder(
        builder: (context) {
          return IconButton(
              icon: SvgPicture.asset(
                Img.icMenu,
                width: 22.0,
                height: 18.0,
              ),
              onPressed: () => _showMenu());
        },
      ),
      actions: <Widget>[
        IconButton(
            icon: SvgPicture.asset(
              Img.icChart,
              width: 35.0,
              color: AppColors.titleTextColor,
            ),
            onPressed: () {}),
        IconButton(
            icon: SvgPicture.asset(
              Img.icEuro,
              width: 14.0,
              color: AppColors.titleTextColor,
            ),
            onPressed: () {}),
        IconButton(
            icon: SvgPicture.asset(
              Img.icAnt,
              width: 20.0,
              color: AppColors.titleTextColor,
            ),
            onPressed: () {}),
      ],
    );
  }

  void _showMenu() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return Menu();
    }));
  }
}
