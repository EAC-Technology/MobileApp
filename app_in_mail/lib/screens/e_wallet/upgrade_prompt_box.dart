import 'package:app_in_mail/constants/colors.dart';
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
                'Light account',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.greyLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'IN 2500 € MAX',
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
                'Upgrade to standard',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.accentColor,
                ),
              ),
              Text(
                'OUT 1000 € MAX',
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
