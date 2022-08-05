import 'dart:convert';

import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:random_words/random_words.dart';

class RandomWordsGenerator {
  final kAdjectiveCount = 90;
  final kNounCount = 90;
  final kTotalWords = 180;
  final kNoWordsPerLine = 6;
  _generateRandomAdjectives(){
    List<String> randomAdjectives = [];
    generateAdjective().take(kAdjectiveCount).forEach((element) {
      randomAdjectives.add(element.asString);
    });
    return randomAdjectives;
  }

  _generateRandomNouns(){
    List<String> randomNouns = [];
    generateNoun().take(kNounCount).forEach((element){
      randomNouns.add(element.asString);
    });
    return randomNouns;
  }

  List<String> generateRandomWords() {
    List<String> randomWords = [];
    randomWords.addAll(_generateRandomAdjectives());
    randomWords.addAll(_generateRandomNouns());
    randomWords.shuffle();

    return randomWords;

  }

  ///180 random words generated and each line will have 6 words
  List<String> generateRandomStrings(List<String> randomWords){
    List<String> randomStrings = <String>[];
    String randomString = '';
    for(int i=1; i <= kTotalWords; i++){
      if((i % kNoWordsPerLine) != 0){
        randomString = randomString + randomWords[i] + ' ';
      }else{
        randomStrings.add(randomString);
        randomString = '';
      }
    }
    return randomStrings;
  }

  List<String> generateLorenIpsum(){
    String text = loremIpsum(words: kTotalWords);
    return text.split(" ");
  }

}
