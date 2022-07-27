import 'dart:core';

class WPMCalculator{

  int uncorrectedErrors = 0;
  double minutes = 0;
  int allTypedEntries = 0;
  int correctlyTypedEntries = 0;

  WPMCalculator({this.uncorrectedErrors,
    this.correctlyTypedEntries, this.allTypedEntries, this.minutes});

  double _calculateGrossWPM(){
    return ((allTypedEntries/5)/minutes);
  }

  double getNetWPM(){
    return (_calculateGrossWPM() - (uncorrectedErrors/minutes)).abs();
  }

  double getAccuracy(){
    return (correctlyTypedEntries/allTypedEntries) * 100;
  }

}