import 'package:app_in_mail/constants/strings/string_keys.dart';
import 'package:app_in_mail/screens/menu/general_info_screen.dart';
import 'package:app_in_mail/screens/menu/menu_item_view.dart';
import 'package:app_in_mail/utils/localization.dart';
import 'package:flutter/material.dart';

class InfoActionList extends StatefulWidget {
  @override
  _InfoActionListState createState() => _InfoActionListState();
}

class _InfoActionListState extends State<InfoActionList> {
  void _navigateToInfoPage(InfoPageTypes infoPageType, String title) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return GeneralInfoScreen(
            pageType: infoPageType,
            title: title,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MenuItemView(
          onTap: () => _navigateToInfoPage(InfoPageTypes.contactAndSupport,
              Localization.getString(Strings.contactAndSupport)),
          title: Localization.getString(Strings.contactAndSupport),
        ),
        MenuItemView(
          onTap: () => _navigateToInfoPage(
              InfoPageTypes.faq, Localization.getString(Strings.faq)),
          title: Localization.getString(Strings.faq),
        ),
        MenuItemView(
          onTap: () => _navigateToInfoPage(
              InfoPageTypes.privacyPolicyAndCookies,
              Localization.getString(Strings.privacyPolicyAndCookies)),
          title: Localization.getString(Strings.privacyPolicyAndCookies),
        ),
        MenuItemView(
          onTap: () => _navigateToInfoPage(InfoPageTypes.sofrwareLicense,
              Localization.getString(Strings.softwareLicense)),
          title: Localization.getString(Strings.softwareLicense),
        ),
        MenuItemView(
          onTap: () => _navigateToInfoPage(
              InfoPageTypes.terms, Localization.getString(Strings.terms)),
          title: Localization.getString(Strings.terms),
        ),
      ],
    );
  }
}
