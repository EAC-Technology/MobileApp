import 'package:app_in_mail/constants/images.dart';
import 'package:app_in_mail/model/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuFilterItem extends StatefulWidget {
  final Function onTap;
  final Label label;
  @override
  MenuFilterItem({this.onTap, this.label});
  _MenuFilterItemState createState() => _MenuFilterItemState();
}

class _MenuFilterItemState extends State<MenuFilterItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.widget.onTap();
      },
      child: Padding(
        padding: EdgeInsets.only(left: 30, top: 10, bottom: 10, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  Img.icLabel,
                  color: widget.label.color,
                  width: 26.0,
                ),
                Container(
                  width: 20,
                ),
                Text(
                  widget.label.name,
                  style: TextStyle(color: widget.label.color, fontSize: 15),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: SvgPicture.asset(
                Img.icFilter,
                color: widget.label.color,
                width: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
