import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 160, top: 1),
            child: SvgPicture.asset(
              Img.icEuro,
              height: 180,
              color: Color.fromARGB(15, 83, 86, 120),
            ),
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
                  style: TextStyle(color: AppColors.titleTextColor),
                ),
                Text(
                  '€ 3.25',
                  style: TextStyle(
                      color: AppColors.titleTextColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'xxxx-xxxx-xxxxx-xxxx-xxxx-xxxx',
                  style: TextStyle(color: AppColors.titleTextColor),
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
                color: Colors.blueGrey[100],
                offset: new Offset(2, 35),
                blurRadius: 20)
          ],
          color: Colors.white,
          borderRadius: new BorderRadius.all(Radius.circular(8))),
    );
  }
}
