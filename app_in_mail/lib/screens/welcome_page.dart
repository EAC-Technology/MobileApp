import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/utils/alertHelper.dart';
import 'package:app_in_mail/utils/logger.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Log.d('test');
    return Scaffold(
      body: Container(
//        color: Colors.white,
        padding: EdgeInsets.only(top:30.0,left: 30.0, right: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //todo put strings in files
                children: <Widget>[
                  Text(
                    'Email became',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('active!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: AppColors.accentColor)),
                  )
                ],
              ),
              Container(
                child: Image.asset(
                  Img.icWelcome,
                  width: 296.0,//todo check to load dynamic size for smaller
                  // screens
                  height: 293.0,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'If earlier the emails contained only text and graphics, now the emails have actions! Email content became active - interact with it like with App!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: AppColors.greyLight),
              ),
              new BtnOK()
            ],
        ),
      ),
    );
  }
}

class BtnOK extends StatelessWidget {
  const BtnOK({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: ()=> AlertHelper.showSnackBar(context, 'Go next'),
      child: Text(
        'OKAY,I SEE',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: AppColors.accentColor),
      ),
    );
  }
}
