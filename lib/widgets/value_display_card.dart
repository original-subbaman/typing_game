import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/utility/constants.dart';

class ValueDisplayCard extends StatelessWidget {
  final String titleText;
  final String valueText;
  final Color bgColor;
  final titleTxtStyle;
  final valueTxtStyle;
  final double paddingHorizontal;
  final double paddingVertical;
  ValueDisplayCard({@required this.titleText, @required this.valueText,
    this.bgColor,
    this.titleTxtStyle,
    this.valueTxtStyle,
    this.paddingHorizontal = 0.0,
    this.paddingVertical = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      shadowColor: Colors.deepPurpleAccent.shade400,
      color: bgColor == null? Colors.black54 : bgColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal == 0.0 ? 20 : paddingHorizontal,
            vertical: paddingVertical == 0.0 ? 20 : paddingVertical,
          ),
          child: Column(
            children: [
              Text(
                titleText,
                textAlign: TextAlign.center,
                style: titleTxtStyle,
              ),
              Text(
                valueText,
                textAlign: TextAlign.center,
                style: valueTxtStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
