
import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/screens/menu/menu_item_view.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class InfoActionList extends StatefulWidget {
  @override
  _InfoActionListState createState() => _InfoActionListState();
}

class _InfoActionListState extends State<InfoActionList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MenuItemView(
          title: Localization.getString(Strings.contactAndSupport),
        ),
        MenuItemView(
          title: Localization.getString(Strings.faq),
        ),
        MenuItemView(
          title: Localization.getString(Strings.privacyPolicyAndCookies),
        ),
        MenuItemView(
          title: Localization.getString(Strings.softwareLicense),
        ),
        MenuItemView(
          title: Localization.getString(Strings.terms),
        ),
      ],
    );
  }
}