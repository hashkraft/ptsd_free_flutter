import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class SettingVariables {
  bool push = false;
  bool randomPTSD = false;
  String last = "none";

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

  Future<void> setAllowRandom(String val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last', val);
    last = val;
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

  Future<String> getAllowRandom() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String val = prefs.getString('last') ?? 'none';
    last = val;
    return val;
  }
}
