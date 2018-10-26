import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class UpgradePromptBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Localization.getString(Strings.lightAccount),
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.greyLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Localization.getString(Strings.lightAccountIn) + " 2500 € " + Localization.getString(Strings.lightAccountMax),
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.titleTextColor,
                ),
              ),
            ],
          ),
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Localization.getString(Strings.upgradeToStandard),
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.accentColor,
                ),
              ),
              Text(
                Localization.getString(Strings.lightAccountOut) + " 1000 € " + Localization.getString(Strings.lightAccountMax),
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.titleTextColor,
                ),
              ),
            ],
          )
          
        ],
      ),
    );
  }
}

//TODO: localization
