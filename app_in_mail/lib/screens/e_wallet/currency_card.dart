import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final Color textColor;
  final Color color;
  final Color shadowColor;
  final String valueText;
  final String idText;
  final Widget watermark;

  CurrencyCard({this.textColor, this.color, this.shadowColor, this.valueText, this.watermark, this.idText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 160, top: 1),
            child: this.watermark
          ),
          Padding(
            padding: const EdgeInsets.only(left: 250, top: 20),
            child: Image.asset(Img.icAppInMailPNG),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Localization.getString(Strings.currentBalance),
                  style: TextStyle(color: this.textColor),
                ),
                Text(
                  this.valueText,
                  style: TextStyle(
                      color: this.textColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  this.idText,
                  style: TextStyle(color: this.textColor),
                ),
              ],
            ),
          ),
        ],
      ),
      width: 320,
      height: 200,
      decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: this.shadowColor,
                offset: new Offset(2, 35),
                blurRadius: 20)
          ],
          color: this.color,
          borderRadius: new BorderRadius.all(Radius.circular(8))),
    );
  }
}
