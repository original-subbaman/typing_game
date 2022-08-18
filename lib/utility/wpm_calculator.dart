import 'dart:core';

class TypingStatCalculator{

  int uncorrectedErrors = 0;
  double minutes = 0;
  int allTypedEntries = 0;
  int correctlyTypedEntries = 0;
  int totalCharacters = 0;

  TypingStatCalculator.wpmCalculator({this.uncorrectedErrors,
    this.correctlyTypedEntries, this.allTypedEntries, this.minutes});

  TypingStatCalculator.accCalculator({this.correctlyTypedEntries, this.totalCharacters});

  double _calculateGrossWPM(){
    return ((allTypedEntries/5)/minutes);
  }

  double getNetWPM(){
    return (_calculateGrossWPM() - (uncorrectedErrors/minutes)).abs();
  }

  double getAccuracy(){
    return (correctlyTypedEntries/totalCharacters) * 100;
  }

}