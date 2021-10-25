import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
    topTitles: SideTitles(
      showTitles: false,
    ),
    rightTitles: SideTitles(
      showTitles: false,
    ),
    bottomTitles: SideTitles(
      showTitles: true,
      reservedSize: 30,
      margin: 8,
      getTitles: (value){
        if(value % 5 == 0) return value.toString();
        return '';
      },
      getTextStyles: (value, textStyle) => TextStyle(
        color: Colors.white,
      ) ,
    ),
    leftTitles: SideTitles(
      showTitles: true,
      getTitles: (value) {
        if(value % 20 == 0) return value.toString();
        return '';
      },
      getTextStyles: (value, textStyle) => TextStyle(
        color: Colors.white,
      ),
      reservedSize: 30,
      interval: 20,

    ),
  );
}