import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/custom_widgets/flat_ripple_button.dart';
import 'package:app_in_mail/screens/home/homePage.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
//        color: Colors.white,
        padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _title(),
            Container(
              child: Image.asset(Img.icWelcome),
            ),
            Text(
              Localization.getString(Strings.welcomeMsg),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, color: AppColors.greyLight),
            ),
            FlatAppButton(Strings.welcomeBtnOK, (context1) => _goHome(context1),
                textWeight: FontWeight.bold, textSize: 16.0),
//            _btnOK(context)
          ],
        ),
      ),
    );
  }

  Row _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          Localization.getString(Strings.welcomeTitle1),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(Localization.getString(Strings.welcomeTitle2),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: AppColors.accentColor)),
        )
      ],
    );
  }

  _goHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new HomePage();
        },
      ),
    );
  }
}
