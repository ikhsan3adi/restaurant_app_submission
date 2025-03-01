import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/main/index_nav_provider.dart';
import 'package:restaurant_app/screens/favorite/favorite_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/setting/setting_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
