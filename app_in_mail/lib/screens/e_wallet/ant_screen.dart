import 'package:app_in_mail/screens/e_wallet/upgrade_prompt_box.dart';
import 'package:flutter/cupertino.dart';

class AntScreen extends StatefulWidget {
  @override
  _AntScreenState createState() => _AntScreenState();
}

class _AntScreenState extends State<AntScreen> {
  @override
  Widget build(BuildContext context) {
       return Column(children: <Widget>[
      UpgradePromptBox(),
    ],);
  }
}