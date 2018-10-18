import 'package:flutter/material.dart';

/// A container that provides animated collapsible header. Simillar to bottom sheets, however it shows from the top.
class CollapsibleHeaderContainer extends StatefulWidget {
  double headerHeight;
  Widget header;
  Widget child;
  CollapsibleHeaderContainer({this.isHeaderCollapsed, this.headerHeight, this.header, this.child}) : super();
  final bool isHeaderCollapsed;
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
        AnimatedContainer(curve: Curves.easeIn, duration: Duration(milliseconds: 300), height: widget.isHeaderCollapsed?0:widget.headerHeight, child: _buildHeader()),
        Expanded(child: widget.child,),
      ],
      
    );
  }

  Widget _buildHeader() {
    return widget.header;
  }
}
 