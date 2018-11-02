import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/screens/home/email_type_cell.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class EmailTypesListScreen extends StatefulWidget {
  @override
  _EmailTypesListScreenState createState() => _EmailTypesListScreenState();
}

class _EmailTypesListScreenState extends State<EmailTypesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(Localization.getString(Strings.compose),
              style: TextStyle(
                  color: AppColors.titleTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22))),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          )),
          child: Icon(
            Icons.clear,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Align( alignment: Alignment.topCenter,
                  child: Wrap(
            children: <Widget>[
              EmailTypeCell(
                title: 'Simple Email',
              ),
              EmailTypeCell(
                title: 'Simple Email',
              ),
              EmailTypeCell(
                title: 'Simple Email',
              ),
              EmailTypeCell(
                title: 'Simple Email',
              ),
              EmailTypeCell(
                title: 'Simple Email',
              ),
              EmailTypeCell(
                title: 'Simple Email',
              ),
              EmailTypeCell(
                title: 'Simple Email',
              ),
              EmailTypeCell(
                title: 'Simple Email',
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}
