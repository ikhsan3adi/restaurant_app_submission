import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/setting/local_notification_provider.dart';
import 'package:restaurant_app/providers/setting/shared_preferences_provider.dart';
import 'package:restaurant_app/providers/theme/theme_mode_provider.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/services/workmanager_service.dart';
import 'package:restaurant_app/static/my_workmanager.dart';

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
          SwitchListTile.adaptive(
            value: context
                .watch<SharedPreferencesProvider>()
                .setting!
                .dailyReminderEnable,
            onChanged: (value) async {
              final localNotificationProvider =
                  context.read<LocalNotificationProvider>();
              final workmanagerService = context.read<WorkmanagerService>();
              final sharedPrefsProvider =
                  context.read<SharedPreferencesProvider>();
              final setting = sharedPrefsProvider.setting!;

              await sharedPrefsProvider.saveSettingValue(setting.copyWith(
                dailyReminderEnable: value,
              ));

              if (setting.dailyReminderEnable) {
                await workmanagerService.runPeriodicTask();
              } else {
                await workmanagerService.cancelTask(
                  MyWorkmanager.periodic.taskName,
                );
                await localNotificationProvider.cancelNotification(
                  LocalNotificationService.dailyReminderNotificationId,
                );
              }
            },
            title: Text('Daily Reminder'),
            subtitle: Text('Go dark for a sleek look and easier reading'),
          ),
        ],
      ),
    );
  }
}
