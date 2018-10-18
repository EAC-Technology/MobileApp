import 'package:flutter/material.dart';

class CollapsibleHeaderContainer extends StatefulWidget {
  @override
  _CollapsibleHeaderContainerState createState() =>
      _CollapsibleHeaderContainerState();
}

class _CollapsibleHeaderContainerState
    extends State<CollapsibleHeaderContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer( duration: Duration(microseconds: 1000), child: Container(height: 101.0, color: Colors.green),),
      ],
    );
  }
}
 