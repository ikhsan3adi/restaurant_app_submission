import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/app.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/providers/detail/new_restaurant_review_provider.dart';
import 'package:restaurant_app/providers/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/providers/favorite/local_database_provider.dart';
import 'package:restaurant_app/providers/home/restaurant_list_provider.dart';
import 'package:restaurant_app/providers/main/index_nav_provider.dart';
import 'package:restaurant_app/providers/search/restaurant_search_provider.dart';
import 'package:restaurant_app/providers/theme/theme_mode_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeModeProvider(),
        ),
        Provider<ApiServices>(
          create: (_) => ApiServices(),
        ),
        Provider(
          create: (_) => LocalDatabaseService(),
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
          create: (context) => LocalDatabaseProvider(
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
      ],
      child: const App(),
    ),
  );
}
