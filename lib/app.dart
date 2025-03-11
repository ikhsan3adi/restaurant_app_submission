import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/data/local/shared_preferences_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/providers/detail/new_restaurant_review_provider.dart';
import 'package:restaurant_app/providers/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/providers/favorite/favorite_local_database_provider.dart';
import 'package:restaurant_app/providers/home/restaurant_list_provider.dart';
import 'package:restaurant_app/providers/main/index_nav_provider.dart';
import 'package:restaurant_app/providers/search/restaurant_search_provider.dart';
import 'package:restaurant_app/providers/setting/local_notification_provider.dart';
import 'package:restaurant_app/providers/setting/shared_preferences_provider.dart';
import 'package:restaurant_app/providers/theme/theme_mode_provider.dart';
import 'package:restaurant_app/screens/detail/detail_screen.dart';
import 'package:restaurant_app/screens/main/main_screen.dart';
import 'package:restaurant_app/screens/search/search_screen.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/services/workmanager_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:restaurant_app/style/theme/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({super.key});

  static Future<Widget> create() async {
    final prefs = await SharedPreferences.getInstance();
    return MultiProvider(
      providers: [
        Provider<ApiServices>(
          create: (_) => ApiServices(),
        ),
        Provider(
          create: (_) => LocalDatabaseService(),
        ),
        Provider(
          create: (_) => SharedPreferencesService(prefs),
        ),
        Provider(
          create: (_) => LocalNotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),
        Provider(
          create: (_) => WorkmanagerService()..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider(
            context.read<SharedPreferencesService>(),
          )..getSettingValue(),
        ),
        ChangeNotifierProvider(
          create: (context) {
            final themeModeProvider = ThemeModeProvider();

            final sharedPrefsProvider =
                context.read<SharedPreferencesProvider>();

            if (sharedPrefsProvider.setting?.darkModeEnable ?? false) {
              themeModeProvider.setDark();
            }

            return themeModeProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteLocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => NewRestaurantReviewProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
      ],
      child: const App(),
    );
  }

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
            NavigationRoute.homeRoute.name: (_) => MainScreen(),
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
