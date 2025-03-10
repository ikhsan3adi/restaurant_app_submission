import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/app.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/data/local/shared_preferences_service.dart';
import 'package:restaurant_app/providers/detail/new_restaurant_review_provider.dart';
import 'package:restaurant_app/providers/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/providers/favorite/favorite_local_database_provider.dart';
import 'package:restaurant_app/providers/home/restaurant_list_provider.dart';
import 'package:restaurant_app/providers/main/index_nav_provider.dart';
import 'package:restaurant_app/providers/search/restaurant_search_provider.dart';
import 'package:restaurant_app/providers/setting/local_notification_provider.dart';
import 'package:restaurant_app/providers/setting/shared_preferences_provider.dart';
import 'package:restaurant_app/providers/theme/theme_mode_provider.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/services/workmanager_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
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
    ),
  );
}
