import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

class SharedPreferencesStorage implements LocalStorage {
  @override
  Future<List<String>?> getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  @override
  Future<void> addString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentList = prefs.getStringList(key) ?? [];
    currentList.add(value);
    await prefs.setStringList(key, currentList);
  }

  @override
  Future<void> deleteString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentList = prefs.getStringList(key) ?? [];
    currentList.remove(value);
    await prefs.setStringList(key, currentList);
  }
}
