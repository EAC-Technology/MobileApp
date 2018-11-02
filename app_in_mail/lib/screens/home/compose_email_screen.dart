import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/custom_widgets/appinmail_textfield.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ComposeEmailScreen extends StatefulWidget {
  @override
  _ComposeEmailScreenState createState() => _ComposeEmailScreenState();
}

class _ComposeEmailScreenState extends State<ComposeEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: AppColors.toolbar,
      elevation: 0.5,
      leading: IconButton(
        icon: Icon(
          Icons.clear,
          size: 30,
        ),
        color: AppColors.titleTextColor,
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.attach_file,
              color: AppColors.titleTextColor,
              size: 30,
            ),
            onPressed: () {}),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Container(
            width: 60,
            child: IconButton(
                icon: SvgPicture.asset(
                  Img.icSend,
                  color: AppColors.accentColor,
                  height: 30,
                ),
                onPressed: () {}),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    var labelTextStyle =
        TextStyle(color: AppColors.titleTextColor, fontSize: 16);
    return SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(Localization.getString(Strings.to),
                    style: labelTextStyle),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppInMailTextField(),
              )),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(Localization.getString(Strings.subject),
                    style: labelTextStyle),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppInMailTextField(),
              )),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                child: Text(Localization.getString(Strings.message),
                    style: labelTextStyle),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: new TextField( 
              keyboardType: TextInputType.multiline,
              maxLines: 20,
            ),
          )
        ],
      ),
    );
  }
}
