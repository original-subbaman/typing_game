import 'package:flutter/material.dart';

class InputFormField extends StatefulWidget{
  final FocusNode focusNode;
  final Function onTap;
  final Icon prefixIcon;
  final String hintText;
  final String labelText;
  final TextStyle labelStyle;
  final TextEditingController controller;
  final bool obscureText;

  const InputFormField({this.focusNode, this.onTap, this.prefixIcon, this.hintText, this.labelText, this.labelStyle, this.controller, this.obscureText});

  @override
  State<StatefulWidget> createState() => _InputFormField();

}

class _InputFormField extends State<InputFormField>{
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.deepPurple),
          labelText: widget.labelText,
          labelStyle: widget.labelStyle,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Colors.deepPurpleAccent))),
    );
  }

}