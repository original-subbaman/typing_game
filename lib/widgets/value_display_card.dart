import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/utility/constants.dart';

class ValueDisplayCard extends StatelessWidget {
  final String titleText;
  String valueText;
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
      elevation: kCardElevation,
      color: bgColor == null? kLightBlueAccent : bgColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal == 0.0 ? 20 : paddingHorizontal,
            vertical: paddingVertical == 0.0 ? 20 : paddingVertical,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: AutoSizeText(
                  titleText,
                  textAlign: TextAlign.center,
                  style: titleTxtStyle,
                  maxFontSize: 40,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: AutoSizeText(
                  valueText,
                  textAlign: TextAlign.center,
                  style: valueTxtStyle,
                  minFontSize: 65,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
