import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:thumbing/model/line_titles.dart';

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColorLine =   [
    Colors.deepOrange,
    Colors.lightBlue,
  ];
  final String chartTitle;


  LineChartWidget(this.chartTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.black54,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 30, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              chartTitle,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: LineTitles.getTitleData(),
                  minX: 0,
                  maxX: 30,
                  minY: 0,
                  maxY: 120,
                  gridData: FlGridData(
                      show: true,
                      verticalInterval: 20,
                      horizontalInterval: 20,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.blueGrey,
                          strokeWidth: 1,
                        );
                      },
                      drawVerticalLine: true,
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                            color: Colors.blueGrey,
                            strokeWidth: 1,
                        );
                      },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 1,
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      colors: [Colors.lightBlueAccent],
                      barWidth: 5,
                      spots: [
                        FlSpot(5, 1),
                        FlSpot(10, 4),
                        FlSpot(15, 20),
                        FlSpot(20, 30),
                        FlSpot(25, 55),
                        FlSpot(30, 89),
                      ],
                    ),
                  ],
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
