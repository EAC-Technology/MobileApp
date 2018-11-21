
import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class EwalletSuccessScreen extends StatefulWidget {
  @override
  _EwalletSuccessScreenState createState() => _EwalletSuccessScreenState();
}

class _EwalletSuccessScreenState extends State<EwalletSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Text('Success')
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        Localization.getString(Strings.operationSuccessful),
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
            Navigator.of(context).push(
                        new MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return EwalletSuccessScreen();
                          },
                        ),
                      );
          }),
    );
  }
}