import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme/theme_mode_provider.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/material_theme.dart';
import 'package:restaurant_app/style/util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(
      context,
      displayFontString: 'Outfit',
      bodyFontString: 'DM Sans',
    );

    MaterialTheme theme = MaterialTheme(textTheme);

    return Consumer<ThemeModeProvider>(
      builder: (context, value, _) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: value.themeMode,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (_) => MainScreen(),
          },
        );
      },
    );
  }
}
