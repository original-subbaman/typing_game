import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColorLine =   [
    Colors.deepOrange,
    Colors.lightBlue,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 100,
          minY: 0,
          maxY: 120,
          gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.lightBlue,
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                    color: Colors.lightBlue,
                    strokeWidth: 1,
                );
              },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              colors: gradientColorLine,
              barWidth: 5,
              spots: [
                FlSpot(10, 1),
                FlSpot(20, 4),
                FlSpot(26, 20),
                FlSpot(44, 30),
                FlSpot(65, 55),
                FlSpot(68, 89),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
