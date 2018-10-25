import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/screens/menu/menu_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class EwalletActionList extends StatefulWidget {
  @override
  _EwalletActionListState createState() => _EwalletActionListState();
}

class _EwalletActionListState extends State<EwalletActionList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MenuItemView(
          title: 'Exchange',
          icon: SvgPicture.asset(
            Img.icExchange,
            width: 22.0,
            height: 18.0,
          ),
        ),
        MenuItemView(
          title: 'EURO eWallet',
          icon: SvgPicture.asset(
            Img.icEuro,
            width: 22.0,
            height: 18.0,
          ),
        ),
        MenuItemView(
          title: '@NT eWallet',
          icon: SvgPicture.asset(
            Img.icAnt,
            width: 22.0,
            height: 18.0,
          ),
        ),
        MenuItemView(
          title: 'Real-time chart',
          icon: SvgPicture.asset(
            Img.icChart,
            width: 22.0,
            height: 18.0,
          ),
        ),
        MenuItemView(
          title: 'Upgrade to Standard',
          icon: SvgPicture.asset(
            Img.icUpgrade,
            width: 22.0,
            height: 18.0,
          ),
        ),
      ],
    );
  }
}

//TODO : add  localizations
