import 'package:app_in_mail/constants/colors.dart';
import 'package:flutter/material.dart';

class LabeledValueBox extends StatelessWidget {
  final String title;
  final String value;

  LabeledValueBox({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 60,
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle( color: AppColors.titleTextColor),),
            Text(value, style: TextStyle( color: AppColors.titleTextColor, fontWeight: FontWeight.bold, fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
