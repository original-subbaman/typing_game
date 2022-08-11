import 'package:shared_preferences/shared_preferences.dart';
class CurrentBestScore{

  static updateBestAcc(int latestAcc) async {
    final prefs = await SharedPreferences.getInstance();
    Future.wait([getBestWPM(prefs)]).then((value){
      if(latestAcc > value[0]){
        prefs.setInt('acc', latestAcc);
      }
    });
  }

  static setBestAcc(int acc) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('acc', acc);
  }

  static updateBestWPM(int latestWPM) async{
    final prefs = await SharedPreferences.getInstance();
    Future.wait([getBestWPM(prefs)]).then((value){
      if(latestWPM > value[0]){
        prefs.setInt('wpm', latestWPM);
      }
    });
  }

  static setBestWPM(int latestWPM) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('wpm', latestWPM);
  }

  static getBestAcc(var prefs) async {
    if(prefs == null){
      prefs = await SharedPreferences.getInstance();
    }
    return prefs.getInt('acc');
  }
  static Future<int> getBestWPM(var prefs) async {
    if(prefs == null){
      prefs = await SharedPreferences.getInstance();
    }
    return prefs.getInt('wpm');
  }
}