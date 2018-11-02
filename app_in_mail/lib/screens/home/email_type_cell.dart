import 'package:app_in_mail/constants/colors.dart';
import 'package:flutter/material.dart';

class EmailTypeCell extends StatelessWidget {
  final String title;

  EmailTypeCell({this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Container(
            width: 85,
            height: 85,
            decoration: new BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: new BorderRadius.all(Radius.circular(8))),
            child: Icon(Icons.mail_outline, color: Colors.white, size: 50,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:10, bottom: 20),
          child: Text(this.title, style: TextStyle( color: AppColors.titleTextColor, fontSize: 10),),
        )
      ],
    );
  }
}