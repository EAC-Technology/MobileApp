import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPersonalDataForm extends StatefulWidget {
  @override
  _EditPersonalDataFormState createState() => _EditPersonalDataFormState();
}

class _EditPersonalDataFormState extends State<EditPersonalDataForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      title: new Text(
        Localization.getString(Strings.personalData),
        style: TextStyle(
            color: AppColors.titleTextColor,
            fontSize: 22.0,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: AppColors.titleTextColor,
            size: 32.0,
          ),
          onPressed: () => Navigator.of(context).pop()),
      
    );
  }
}
