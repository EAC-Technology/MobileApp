import 'package:flutter/material.dart';

import 'dart:async';

class AlertHelper {
  static Future<Null> showErrorMessage(
      BuildContext context, String errorTitle, String errorMessage) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
            title: new Text(errorTitle), content: Text(errorMessage));
      },
    );
  }
}
