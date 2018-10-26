import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
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
      body: Container(),
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
            onPressed: () {
              
            }),
            IconButton(
            icon: SvgPicture.asset(
              Img.icEuro,
              width: 14.0,
              color: AppColors.titleTextColor,
            ),
            onPressed: () {
              
            }),
            IconButton(
            icon: SvgPicture.asset(
              Img.icAnt,
              width: 20.0,
              color: AppColors.titleTextColor,
            ),
            onPressed: () {
              
            }),
      ],
    );
  }

  void _showMenu() {
    Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
                 builder: (BuildContext context) {
                    return  Menu();
                }
    ));
  }


}