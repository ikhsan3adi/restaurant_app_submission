import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/main/index_nav_provider.dart';
import 'package:restaurant_app/screens/favorite/favorite_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/setting/setting_screen.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) {
      if (mounted && (payload?.isNotEmpty ?? false)) {
        goToDetailScreen(context, payload!);
      }
    });
  }

  void goToDetailScreen(BuildContext context, String payload) {
    Navigator.pushNamed(
      context,
      NavigationRoute.detailRoute.name,
      arguments: {
        'restaurant': json.decode(payload) as Map<String, dynamic>,
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final notificationAppLaunchDetails =
          await localNotificationsPlugin.getNotificationAppLaunchDetails();

      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        final response = notificationAppLaunchDetails!.notificationResponse;

        final payload = response?.payload;

        if (mounted && (payload?.isNotEmpty ?? false)) {
          goToDetailScreen(context, payload!);
        }
      }
    });

    _configureSelectNotificationSubject();
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, _) => switch (value.indexBottomNavBar) {
          1 => const FavouriteScreen(),
          2 => const SettingScreen(),
          _ => const HomeScreen(),
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (value) {
          context.read<IndexNavProvider>().indexBottomNavBar = value;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorite',
            tooltip: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Setting',
            tooltip: 'Setting',
          ),
        ],
      ),
    );
  }
}
