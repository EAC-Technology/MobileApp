import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/screens/e_wallet/ant_screen.dart';
import 'package:app_in_mail/screens/e_wallet/chart_screen.dart';
import 'package:app_in_mail/screens/e_wallet/euro_screen.dart';
import 'package:app_in_mail/screens/e_wallet/exchange_screen.dart';
import 'package:app_in_mail/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum EwalletScreenMode { chart, exchange, euro, ant }

class EwalletScreen extends StatefulWidget {
  final EwalletScreenMode initialMode;
  EwalletScreen({this.initialMode});

  @override
  _EwalletScreenState createState() => _EwalletScreenState();
}

class _EwalletScreenState extends State<EwalletScreen> {
  @override
  void initState() {
    this._mode = widget.initialMode;
    super.initState();
  }

  EwalletScreenMode _mode = EwalletScreenMode.exchange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.eWalletBackground,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (this._mode) {
      case EwalletScreenMode.ant:
        return AntScreen();
      case EwalletScreenMode.chart:
        return ChartScreen();
      case EwalletScreenMode.euro:
        return EuroScreen();
      case EwalletScreenMode.exchange:
        return ExchangeScreen();
    }

    return Container();
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
            onPressed: () {
              setState(() {
                this._mode = EwalletScreenMode.chart;
              });
            }),
        IconButton(
            icon: SvgPicture.asset(
              Img.icEuro,
              width: 14.0,
              color: AppColors.titleTextColor,
            ),
            onPressed: () {
              setState(() {
                this._mode = EwalletScreenMode.euro;
              });
            }),
        IconButton(
            icon: SvgPicture.asset(
              Img.icAnt,
              width: 20.0,
              color: AppColors.titleTextColor,
            ),
            onPressed: () {
              setState(() {
                this._mode = EwalletScreenMode.ant;
              });
            }),
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
