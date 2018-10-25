import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItemView extends StatefulWidget {
  final String title;
  final SvgPicture icon;
  final Color textColor;
  MenuItemView({this.textColor = Colors.white, this.title, this.icon});

  @override
  _MenuItemViewState createState() => _MenuItemViewState();
}

class _MenuItemViewState extends State<MenuItemView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 20, bottom: 20, right: 20),
      child: Row(
        children: <Widget>[
          widget.icon != null
              ? Container(
                  child: widget.icon,
                  width: 25,
                )
              : Container(),
          Container(
            width: 20,
          ),
          Text(
            widget.title,
            style: TextStyle(color: widget.textColor, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
