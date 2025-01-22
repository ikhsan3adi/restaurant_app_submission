import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme/theme_mode_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
      ),
      body: Center(
        child: OutlinedButton.icon(
          onPressed: () {
            context.read<ThemeModeProvider>().toggleTheme();
          },
          label: Text('Toggle theme'),
          icon: Icon(
            context.watch<ThemeModeProvider>().themeMode == ThemeMode.light
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
        ),
      ),
    );
  }
}
