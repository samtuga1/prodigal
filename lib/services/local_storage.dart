import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences prefs;
  LocalStorage(this.prefs);

  Future<String?> getString(String path) async {
    return prefs.getString(path);
  }

  Future<bool?> getBool(String path) async {
    return prefs.getBool(path);
  }

  Future<void> remove(String path) async {
    await prefs.remove(path);
  }

  Future<void> setString(String path, String value) async {
    await prefs.setString(path, value);
  }

  Future<void> setBool(String path, bool value) async {
    await prefs.setBool(path, value);
  }

  Future<void> clear() async {
    await prefs.clear();
  }
}
