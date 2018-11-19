import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/screens/e_wallet/currency_box.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  bool antToEurMode = false;

  @override
  Widget build(BuildContext context) {
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
            Container(
              height: 180,
              child: Stack(
                children: <Widget>[
                  AnimatedPadding(
                    child: CurrencyBox(
                      icon: SvgPicture.asset(
                        Img.icEuro,
                        width: 16.0,
                        color: AppColors.titleTextColor,
                      ),
                      valueColor: AppColors.titleTextColor,
                      text: '100000',
                      title: this.antToEurMode?Localization.getString(Strings.youHave):Localization.getString(Strings.youGet),
                    ),
                    duration: Duration(milliseconds: 300),
                    padding: antToEurMode
                        ? EdgeInsets.only(top: 0)
                        : EdgeInsets.only(top: 80),
                  ),
                  AnimatedPadding(
                    child: CurrencyBox(
                      icon: SvgPicture.asset(
                        Img.icAnt,
                        width: 24.0,
                        color: AppColors.accentColor,
                      ),
                      text: '2.002',
                      valueColor: AppColors.accentColor,
                      title: this.antToEurMode?Localization.getString(Strings.youGet):Localization.getString(Strings.youHave),
                    ),
                    duration: Duration(milliseconds: 300),
                    padding: antToEurMode
                        ? EdgeInsets.only(top: 80)
                        : EdgeInsets.only(top: 0),
                  ),
                ],
              ),
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
                      setState(() {
                        this.antToEurMode = !this.antToEurMode;
                      });
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
}
