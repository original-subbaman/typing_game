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
      backgroundColor: kBGColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: kLightBlueAccent, size: 35),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 5,
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
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Material(
                elevation: kCardElevation,
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
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                        Text(
                          args.bestValueText,
                          style: kCardTextStyle.copyWith(
                            color: Colors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: LineChartWidget(kWPMChartTile),
            )
          ],
        ),
      ),
    ));
  }
}
