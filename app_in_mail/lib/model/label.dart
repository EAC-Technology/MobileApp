import 'package:flutter/material.dart';
class Label {
  final String name;
  
  final String colorHex;
  final String textColorHex;
  
  Color get color =>  Color(int.parse("0x$colorHex")).withOpacity(1.0).withAlpha(255);
  Color get textColor =>  Color(int.parse("0x$textColorHex")).withOpacity(1.0).withAlpha(255);

  Label(
      {this.name,
      this.colorHex,
      this.textColorHex,
  });

  factory Label.fromJson(Map<dynamic, dynamic> json) {
    final map = json;
    String colorHex = map['color'];
    String textColorHex = map['text_color'];
    
    return Label(
      name: map['name'],
      colorHex: colorHex,
      textColorHex :textColorHex,
    );
  }
}
