import 'package:shared_preferences/shared_preferences.dart';

class SettingVariables {
  bool push = false;
  bool randomPTSD = true;

  Future<void> setPush(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('push', val);
    push = val;
  }

  Future<void> setRandomPTSD(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('randomPTSD', val);
    randomPTSD = val;
  }

  Future<bool> getPush() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool val = prefs.getBool('push') ?? false;
    push = val;
    return val;
  }

  Future<bool> getRandomPTSD() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool val = prefs.getBool('randomPTSD') ?? false;
    randomPTSD = val;
    return val;
  }
}
