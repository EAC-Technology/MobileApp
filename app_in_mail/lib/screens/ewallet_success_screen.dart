import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class EwalletSuccessScreen extends StatefulWidget {
  final String title;
  EwalletSuccessScreen({this.title});

  @override
  _EwalletSuccessScreenState createState() => _EwalletSuccessScreenState();
}

class _EwalletSuccessScreenState extends State<EwalletSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.check_box, color: AppColors.accentColor, size: 40,),
              Text(Localization.getString(Strings.operationSuccessful), style: TextStyle(fontSize: 22),),
            ],
          )),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        widget.title,
        style: TextStyle(
            color: AppColors.titleTextColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: AppColors.titleTextColor,
            size: 32.0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
    );
  }
}
