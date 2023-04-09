import 'package:flutter/material.dart';

class SocialMediaButton extends StatefulWidget{
  final String logoResource;
  final VoidCallback? onPressed;
  const SocialMediaButton({required this.logoResource, required this.onPressed});

  @override
  State<SocialMediaButton> createState() => _SocialMediaButtonState();
}

class _SocialMediaButtonState extends State<SocialMediaButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: Image(
          image:
          AssetImage(widget.logoResource),
          height: 45.0,
        ),
      ),
      onPressed: widget.onPressed,
    );
  }
}