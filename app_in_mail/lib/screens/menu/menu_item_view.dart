import 'package:flutter/material.dart';


class MenuItemView extends StatefulWidget {
  final String title;
  final Widget icon;
  final Color textColor;
  final Function onTap;
  final double verticalPadding;
  final FontWeight fontWeight;
  final double fontSize;
  MenuItemView({this.onTap,this.textColor = Colors.white, this.title, this.icon, this.verticalPadding = 20, this.fontWeight = FontWeight.normal, this.fontSize = 20});

  @override
  _MenuItemViewState createState() => _MenuItemViewState();
}

class _MenuItemViewState extends State<MenuItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          this.widget.onTap();
        },
        child: Padding(
        padding: EdgeInsets.only(left: 30, top: widget.verticalPadding, bottom: widget.verticalPadding, right: 20),
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
              style: TextStyle(color: widget.textColor, fontSize: widget.fontSize, fontWeight: widget.fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}
