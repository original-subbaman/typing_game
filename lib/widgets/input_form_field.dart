import 'package:flutter/material.dart';
import 'package:thumbing/utility/colors.dart';

class InputFormField extends StatefulWidget {
  final FocusNode focusNode;
  final VoidCallback? onTap;
  final Icon prefixIcon;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const InputFormField(
      {required this.focusNode,
      required this.onTap,
      required this.prefixIcon,
      required this.hintText,
      required this.controller,
      required this.obscureText});

  @override
  State<StatefulWidget> createState() => _InputFormField();
}

class _InputFormField extends State<InputFormField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: shades[1],
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: kLightBlueAccent),
          ),
        ),
      ),
    );
  }
}
