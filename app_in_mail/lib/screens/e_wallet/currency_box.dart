import 'package:app_in_mail/constants/colors.dart';
import 'package:flutter/material.dart';

class CurrencyBox extends StatefulWidget {
  final Color valueColor;
  final Widget icon;
  final String title;
  final TextEditingController controller;
  final bool canEdit;

  final Function onChanged;

  CurrencyBox({this.title, this.icon, this.valueColor, this.controller, this.canEdit = false, this.onChanged});

  @override
  _CurrencyBoxState createState() => _CurrencyBoxState();
}

class _CurrencyBoxState extends State<CurrencyBox> {
  Widget _buildValueText() {
    if (widget.canEdit) {
      return Container(
        width: 140,
        child: TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            keyboardType: TextInputType.numberWithOptions(),
            style: TextStyle(color: widget.valueColor, fontSize: 28)),
      );
    } else {
      return Text(widget.controller.text,
          textAlign: TextAlign.right,
          style: TextStyle(color: widget.valueColor, fontSize: 28));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Container(
        width: 250,
        height: 64,
        decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(2, 15),
                  blurRadius: 20)
            ],
            color: Colors.white,
            borderRadius: new BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 60,
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(color: AppColors.titleTextColor),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                _buildValueText(),
                Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(width: 30, child: widget.icon)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
