import 'package:flutter/material.dart';

class AppInMailTextField extends StatefulWidget {

  final TextEditingController controller;
  final TextInputType keyboardType; 
  final bool obscureText;
  final String hintText;
  final ValueChanged<String> onChanged;
  
  
  AppInMailTextField({this.controller, this.keyboardType,this.hintText = "", this.obscureText = false, this.onChanged});

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
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            controller: widget.controller,
            focusNode: _focusNode,
            style: TextStyle(color: Colors.black87),
            decoration: new InputDecoration(
              hintText: widget.hintText,
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