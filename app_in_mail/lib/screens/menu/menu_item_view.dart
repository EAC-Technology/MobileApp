import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/model/mailbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItemView extends StatefulWidget {
  final Mailbox mailbox;
  MenuItemView({this.mailbox});

  @override
  _MenuItemViewState createState() => _MenuItemViewState();
}

class _MenuItemViewState extends State<MenuItemView> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
    child: Row( children: <Widget>[
      SvgPicture.asset(
                  Img.icFolder,
                  width: 26.0,
                ),
                Container(
                  width: 15,
                ), //spacing between icon and tittle
                Text(
                  'Exchange',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
    ],), );
  }
}