import 'package:flutter/material.dart';
import 'package:thumbing/model/expanded_screen_arguments.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/widgets/line_chart_widget.dart';
import 'package:thumbing/widgets/value_display_card.dart';

class ExpandedWPMScreen extends StatelessWidget {
  static const kExpandedWPMScreen = 'expanded_wpm_screen';
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ExpandedScreenArguments;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.deepPurple.shade700,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              child: Hero(
                tag: 'wpmExpand',
                child: ValueDisplayCard(
                  titleText: args.titleText,
                  valueText: args.valueText,
                  titleTxtStyle: kCardTextStyle.copyWith(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                  valueTxtStyle: kCardTextStyle.copyWith(
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 1,
              child: Material(
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
                            'Best WPM achieved',
                            textAlign: TextAlign.left,
                            style: kCardTextStyle.copyWith(
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        Text(
                          args.bestValueText,
                          style: kCardTextStyle.copyWith(
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 2,
              child: LineChartWidget(),
            )
          ],
        ),
      ),
    ));
  }
}
