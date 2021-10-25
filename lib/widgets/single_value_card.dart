import 'package:flutter/material.dart';
import 'package:thumbing/utility/constants.dart';
class SingleValueCard extends StatelessWidget {
  final String valueTitle;
  final String value;

  SingleValueCard(this.valueTitle, this.value);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      shadowColor: Colors.deepPurpleAccent.shade400,
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  valueTitle,
                  textAlign: TextAlign.left,
                  style: kCardTextStyle.copyWith(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Text(value,
                  style: kCardTextStyle.copyWith(
                    color: Colors.deepPurple,
                  )),
              kRankUpIcon,
            ],
          ),
        ),
      ),
    );
  }
}
