import 'package:app_in_mail/screens/menu/menu_item_view.dart';
import 'package:flutter/cupertino.dart';

class EwalletActionList extends StatefulWidget {
  @override
  _EwalletActionListState createState() => _EwalletActionListState();
}

class _EwalletActionListState extends State<EwalletActionList> {
  @override
  Widget build(BuildContext context) {
     return Column( children: <Widget>[
       MenuItemView(),
       MenuItemView(),
       MenuItemView(),
       MenuItemView(),
       MenuItemView(),
     ],);
  }
}


