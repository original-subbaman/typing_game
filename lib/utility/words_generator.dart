import 'dart:convert';

import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:word_generator/word_generator.dart';

class RandomWordsGenerator {
  final kVerbCount = 90;
  final kNounCount = 90;
  final kTotalWords = 180;
  final kNoWordsPerLine = 6;
  final kWordGenerator = WordGenerator();
  _generateRandomVerbs(){
    List<String> randomVerbs = [];
    for(var i = 0; i < kVerbCount; i++){
      randomVerbs.add(kWordGenerator.randomVerb());
    }

    return randomVerbs;
  }

  _generateRandomNouns(){
    List<String> randomNouns = [];
    for(var i = 0; i < kNounCount; i++){
      randomNouns.add(kWordGenerator.randomNoun());
    }
    return randomNouns;
  }

  List<String> generateRandomWords() {
    List<String> randomWords = [];
    randomWords.addAll(_generateRandomVerbs());
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
