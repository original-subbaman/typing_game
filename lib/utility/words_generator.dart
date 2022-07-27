import 'package:random_words/random_words.dart';

class RandomWordsGenerator {
  static generateRandomWords() {
    List<String> randomWords = [];

    generateAdjective().take(90).forEach((element) {
      randomWords.add(element.asString);
    });
    generateNoun().take(90).forEach((element){
      randomWords.add(element.asString);
    });

    randomWords.shuffle();
    List<String> randomStrings = <String>[];
    String randomString = '';

    for(int i=1; i <= 180; i++){
      if((i % 6) != 0){
        randomString = randomString + randomWords[i] + ' ';
      }else{
        randomStrings.add(randomString);
        randomString = '';
      }
    }

    return randomStrings;
  }

}
