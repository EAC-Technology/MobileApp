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
  final _formKey = GlobalKey<FormState>();

  _validateEmptyField(value) {
    if (value.isEmpty) {
      return Localization.getString(Strings.thisFieldisRequired);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(Localization.getString(Strings.login)),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: TextFormField(
                  validator: (value) => _validateEmptyField(value),
                ),
              ),
              Divider(),
              Text(Localization.getString(Strings.firstName)),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: TextFormField(
                  validator: (value) => _validateEmptyField(value),
                ),
              ),
              Divider(),
              Text(Localization.getString(Strings.lastName)),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: TextFormField(
                  validator: (value) => _validateEmptyField(value),
                ),
              ),
              Divider(),
              Text(Localization.getString(Strings.email)),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: TextFormField(
                  validator: (value) => _validateEmptyField(value),
                ),
              ),
              Divider(),
              Text(Localization.getString(Strings.language)),
              DropdownButton( isExpanded: true,
                value: 'English',
                items: <String>['English', 'français',].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(), onChanged: (String value) {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                    child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text(
                    Localization.getString(Strings.save),
                    style: TextStyle(fontSize: 20),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
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
