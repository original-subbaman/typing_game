import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:math';
class FileReader{

  final String _pathRoot = 'assets/text';

  int _getRandomInteger(){
    return Random().nextInt(10);
  }

  Future<String> getFileData() async {
    return await rootBundle.loadString('$_pathRoot/test1.txt');
  }
}