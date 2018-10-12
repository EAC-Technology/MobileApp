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

  static showSnackBar(BuildContext context, String msg){
    final snackBar = SnackBar(content: Text(msg));

// Find the Scaffold in the Widget tree and use it to show a SnackBar
    ScaffoldState scaffoldState = Scaffold.of(context, nullOk: true);
    if (scaffoldState != null){
      scaffoldState.showSnackBar(snackBar);
    }else{//fallback to popup
      showDialog<Null>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return new AlertDialog(content: Text(msg));
        },
      );
    }
  }
}
