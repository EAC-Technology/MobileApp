import 'package:flutter/material.dart';

class AppInMailTextField extends StatefulWidget {

  final TextEditingController controller;
  final TextInputType keyboardType; 
  final bool obscureText;
  
  AppInMailTextField(this.controller, this.keyboardType, this.obscureText);

  @override
  _AppInMailTextFieldState createState() => new _AppInMailTextFieldState();
}


class _AppInMailTextFieldState extends State<AppInMailTextField> {
  FocusNode _focusNode;
  
  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // We just trigger a rerender here.
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            controller: widget.controller,
            focusNode: _focusNode,
            style: TextStyle(color: Colors.black87),
            decoration: new InputDecoration(
              filled: !_focusNode.hasFocus,
              border: new UnderlineInputBorder (
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
               ),
            ),
          );
  }
}