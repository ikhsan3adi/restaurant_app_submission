import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme/theme_mode_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/search/search_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:restaurant_app/style/theme/util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(
      context,
      displayFontString: 'Outfit',
      bodyFontString: 'DM Sans',
    );

    RestaurantTheme theme = RestaurantTheme(textTheme);

    return Consumer<ThemeModeProvider>(
      builder: (context, value, _) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: value.themeMode,
          initialRoute: NavigationRoute.homeRoute.name,
          routes: {
            NavigationRoute.homeRoute.name: (_) => HomeScreen(),
            NavigationRoute.detailRoute.name: (context) {
              // TODO: parameter id
              return DetailScreen();
            },
            NavigationRoute.searchRoute.name: (context) {
              // TODO: parameter query
              return SearchScreen();
            },
          },
        );
      },
    );
  }
}
