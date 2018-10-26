import 'package:flutter/material.dart';

class CurrencyCard extends StatefulWidget {
  @override
  _CurrencyCardState createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10.0, bottom: 10),
      child: Container(
      width: 250 ,
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
        
      ),
    );
  }
}