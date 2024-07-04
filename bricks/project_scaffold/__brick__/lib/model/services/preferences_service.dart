import 'package:rctv_test/root_app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  late final SharedPreferences _preferences;

  final String prefix = RootAppConfig.sharedPreferencePrefix;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Create
  Future<void> saveItem(String key, dynamic value) async {
    key = prefix + key;

    if (value is String) {
      await _preferences.setString(key, value);
    } else if (value is int) {
      await _preferences.setInt(key, value);
    } else if (value is double) {
      await _preferences.setDouble(key, value);
    } else if (value is bool) {
      await _preferences.setBool(key, value);
    } else if (value is List<String>) {
      await _preferences.setStringList(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  }

  // Read
  dynamic getItem(String key) {
    return _preferences.get(prefix + key);
  }

  // Update
  Future<void> updateItem(String key, dynamic value) async {
    if (!_preferences.containsKey(prefix + key)) {
      throw Exception('Key does not exist');
    }
    await saveItem(key, value);
  }

  // Delete
  Future<void> deleteItem(String key) async {
    key = prefix + key;
    if (!_preferences.containsKey(key)) {
      throw Exception('Key does not exist');
    }
    await _preferences.remove(key);
  }
}
