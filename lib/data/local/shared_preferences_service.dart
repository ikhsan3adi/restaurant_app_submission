import 'package:restaurant_app/data/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String darkModeKey = 'DARK_MODE_THEME';
  static const String dailyReminderKey = 'DAILY_REMINDER_ENABLED';

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _preferences.setBool(darkModeKey, setting.darkModeEnable);
      await _preferences.setBool(dailyReminderKey, setting.dailyReminderEnable);
    } catch (e) {
      throw Exception('Shared preferences cannot save the setting value.');
    }
  }

  Setting getSettingValue() {
    return Setting(
      darkModeEnable: _preferences.getBool(darkModeKey) ?? false,
      dailyReminderEnable: _preferences.getBool(dailyReminderKey) ?? true,
    );
  }
}
