import 'package:flutter/material.dart';
class Label {
  final String name;
  final Color color;
  final Color textColor;


  Label(
      {this.name,
      this.color,
      this.textColor,
  });

  factory Label.fromJson(Map<dynamic, dynamic> json) {
    final map = json;
    String hexStringColor = map['color'];
    String hexStringTextColor = map['text_color'];
    Color color =  Color(int.parse("0x$hexStringColor")).withOpacity(1.0).withAlpha(255);
    Color textColor = Color(int.parse("0x$hexStringTextColor")).withOpacity(1.0).withAlpha(255);

    return Label(
      name: map['name'],
      color: color,
      textColor :textColor,
    );
  }
}
