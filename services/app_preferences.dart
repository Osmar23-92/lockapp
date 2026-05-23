import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences _prefs;

  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  
  static bool get isVolumeLocked => _prefs.getBool('isVolumeLocked') ?? false;
  static double get lockedVolumeValue => _prefs.getDouble('lockedVolumeValue') ?? 0.0;

  
  static Future<void> setVolumeLocked(bool value) async {
    await _prefs.setBool('isVolumeLocked', value);
  }

  static Future<void> setLockedVolumeValue(double value) async {
    await _prefs.setDouble('lockedVolumeValue', value);
  }
}