import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/app.dart';
import 'package:restaurant_app/provider/theme/theme_mode_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeModeProvider(),
        ),
      ],
      child: const App(),
    ),
  );
}
