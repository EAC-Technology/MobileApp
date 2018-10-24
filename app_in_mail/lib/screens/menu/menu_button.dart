import 'package:app_in_mail/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuButton extends StatefulWidget {
  final Color color;
  final Widget child;
  final bool isSelected;
  final bool hasNewItems;
  @override
  MenuButton(
      {this.color,
      this.child,
      this.isSelected = false,
      this.hasNewItems = false});
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: new BoxDecoration(
                border: widget.isSelected
                    ? Border.all(0, color: Colors.white, width: 2)
                    : null,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[900],
                      offset: new Offset(2, 15),
                      blurRadius: 10)
                ],
                color: widget.color,
                borderRadius: new BorderRadius.all(Radius.circular(8))),
            child: Center(
              child: widget.child,
            ),
          ),
        ),
        widget.hasNewItems
            ? SvgPicture.asset(
                Img.icDot,
                color: Colors.white,
                width: 10.0,
              )
            : Container(
                width: 10,
              )
      ],
    );
  }
}
