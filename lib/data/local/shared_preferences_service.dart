import 'package:restaurant_app/data/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String darkModeKey = 'DARK_MODE_THEME';

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _preferences.setBool(darkModeKey, setting.darkModeEnable);
    } catch (e) {
      throw Exception('Shared preferences cannot save the setting value.');
    }
  }

  Setting getSettingValue() {
    return Setting(
      darkModeEnable: _preferences.getBool(darkModeKey) ?? false,
    );
  }
}
