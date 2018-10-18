import 'package:flutter/material.dart';

/// A container that provides animated collapsible header. Simillar to bottom sheets, however it shows from the top.
class CollapsibleHeaderContainer extends StatefulWidget {
  final double headerHeight;
  final Widget header;
  final Widget child;
  final bool isHeaderCollapsed;
  
  CollapsibleHeaderContainer({this.isHeaderCollapsed, this.headerHeight, this.header, this.child}) : super();
  
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
        AnimatedContainer(
            decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey[900], offset: new Offset(0.0, 5.0), blurRadius: 20.0
            )], ),
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 100),
            height: widget.isHeaderCollapsed ? 0 : widget.headerHeight,
            child: _buildHeader()),
        Expanded(child: widget.child,),
      ],
      
    );
  }

  Widget _buildHeader() {
    return widget.header;
  }
}
 