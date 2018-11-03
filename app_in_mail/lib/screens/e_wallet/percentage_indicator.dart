import 'package:flutter/material.dart';

class PercentageIndicator extends StatelessWidget {
  final double percentValue;
  PercentageIndicator({this.percentValue});

  @override
  Widget build(BuildContext context) {
    var color = percentValue > 0 ? Colors.green : Colors.red;

    var icon = percentValue > 0 ? Icons.arrow_drop_up: Icons.arrow_drop_down;

    return Container(
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Icon(
              icon,
              color: color,
              size: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              percentValue.toString() + "%",
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
