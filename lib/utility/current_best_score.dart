import 'package:shared_preferences/shared_preferences.dart';
class CurrentBestScore{

  static setLatestAcc(int acc) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('acc', acc);
  }

  static setLatestWPM(int latestWPM) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('wpm', latestWPM);
  }

  static getLatestAcc() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt('acc');
  }
  static getLatestWPM() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt('wpm');
  }
}