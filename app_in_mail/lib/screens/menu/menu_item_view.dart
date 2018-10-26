import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItemView extends StatefulWidget {
  final String title;
  final SvgPicture icon;
  final Color textColor;
  final Function onTap;
  final double verticalPadding;
  final FontWeight fontWeight;
  MenuItemView({this.onTap,this.textColor = Colors.white, this.title, this.icon, this.verticalPadding = 2, this.fontWeight = FontWeight.normal});

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
              style: TextStyle(color: widget.textColor, fontSize: 20, fontWeight: widget.fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}
