import 'package:app_in_mail/constants/colors.dart';
import 'package:app_in_mail/screens/menu/folder_list_view.dart';

import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Center(
          
            child: Container(child: FolderListView(), height: 500, width: 300,),
        ));
  }
}



