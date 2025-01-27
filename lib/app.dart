import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/providers/theme/theme_mode_provider.dart';
import 'package:restaurant_app/screens/detail/detail_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/search/search_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:restaurant_app/style/theme/util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(
      context,
      displayFontString: 'Outfit',
      bodyFontString: 'DM Sans',
    );

    final theme = RestaurantTheme(textTheme);

    return Consumer<ThemeModeProvider>(
      builder: (context, value, _) {
        return MaterialApp(
          title: 'QuickRestaurant',
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: value.themeMode,
          initialRoute: NavigationRoute.homeRoute.name,
          routes: {
            NavigationRoute.homeRoute.name: (_) => HomeScreen(),
            NavigationRoute.detailRoute.name: (context) {
              final args = ModalRoute.of(context)!.settings.arguments as Map;
              return DetailScreen(
                restaurant: Restaurant.fromJson(args['restaurant']),
                imageHeroTag: args['imageHeroTag'],
                titleHeroTag: args['titleHeroTag'],
              );
            },
            NavigationRoute.searchRoute.name: (_) => SearchScreen(),
          },
        );
      },
    );
  }
}
