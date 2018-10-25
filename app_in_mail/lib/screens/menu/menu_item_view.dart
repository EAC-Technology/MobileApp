import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItemView extends StatefulWidget {
  final String title;
  final SvgPicture icon;

  MenuItemView({this.title, this.icon});

  @override
  _MenuItemViewState createState() => _MenuItemViewState();
}

class _MenuItemViewState extends State<MenuItemView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
      child: Row(
        children: <Widget>[
          widget.icon,
          Container(width: 15,),
          Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
