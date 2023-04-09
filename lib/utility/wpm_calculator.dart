import 'dart:core';

class TypingStatCalculator{

  int uncorrectedErrors = 0;
  double minutes = 0;
  int allTypedEntries = 0;
  int correctlyTypedEntries = 0;
  int totalCharacters = 0;

  TypingStatCalculator.wpmCalculator({required this.uncorrectedErrors,
    required this.correctlyTypedEntries, required this.allTypedEntries, required this.minutes});

  TypingStatCalculator.accCalculator({required this.correctlyTypedEntries, required this.totalCharacters});

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