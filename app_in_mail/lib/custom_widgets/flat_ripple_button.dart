import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class FlatAppButton extends StatelessWidget {
  final String stringKey;
  final Function action;
  final TextStyle textStyle;
  final double textSize;
  final FontWeight textWeight;
  final Color textColor;

  ///Important pass the String id instead of actual string
  FlatAppButton(this.stringKey, this.action, {this.textStyle, this.textSize,
    this.textWeight, this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => action(context),
      splashColor: AppColors.darkSplash,
      child: Text(
        Localization.getString(stringKey),
        textAlign: TextAlign.center,
        style: textStyle == null
            ? TextStyle(
            fontWeight: textWeight == null ? FontWeight.normal : textWeight,
            fontSize: textSize == null ? 13.0 : textSize,
            color: textColor == null ? AppColors.accentColor : textColor)
            : textStyle,
      ),
    );
  }
}
