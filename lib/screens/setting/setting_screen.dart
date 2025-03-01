import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/setting/shared_preferences_provider.dart';
import 'package:restaurant_app/providers/theme/theme_mode_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: context.watch<ThemeModeProvider>().isDark,
            onChanged: (_) async {
              final themeModeProvider = context.read<ThemeModeProvider>();
              final sharedPrefsProvider =
                  context.read<SharedPreferencesProvider>();
              final setting = sharedPrefsProvider.setting!;

              themeModeProvider.toggleTheme();

              await sharedPrefsProvider.saveSettingValue(setting.copyWith(
                darkModeEnable: themeModeProvider.isDark,
              ));
            },
            title: Text('Dark Mode'),
            subtitle: Text('Go dark for a sleek look and easier reading'),
          ),
          // TODO: Daily Reminder
        ],
      ),
    );
  }
}
