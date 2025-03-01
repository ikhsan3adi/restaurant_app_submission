import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/local/shared_preferences_service.dart';
import 'package:restaurant_app/data/model/setting.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SharedPreferencesProvider(this._service);

  String _message = '';
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _service.saveSettingValue(setting);
      _message = 'Your data is saved';
    } catch (_) {
      _message = 'Failed to save your data';
    }
    notifyListeners();
  }

  void getSettingValue() {
    try {
      _setting = _service.getSettingValue();
      _message = 'Data successfully retrieved';
    } catch (e) {
      _message = 'Failed to get your data';
    }
    notifyListeners();
  }
}
