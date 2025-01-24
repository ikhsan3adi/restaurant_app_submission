import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme/theme_mode_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class HomeScreenAppBarWidget extends StatelessWidget {
  const HomeScreenAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      flexibleSpace: FlexibleSpaceBar(
        title: Text('QuickRestaurant'),
        titlePadding: EdgeInsets.all(16),
      ),
      actions: [
        IconButton(
          tooltip: 'Search Restaurant',
          onPressed: () {
            Navigator.pushNamed(context, NavigationRoute.searchRoute.name);
          },
          icon: Hero(
            tag: 'search-btn',
            child: Icon(Icons.search),
          ),
        ),
        IconButton(
          tooltip: 'Switch Theme',
          onPressed: () {
            context.read<ThemeModeProvider>().toggleTheme();
          },
          icon: Consumer<ThemeModeProvider>(
            builder: (context, value, _) {
              return Icon(
                value.themeMode == ThemeMode.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              );
            },
          ),
        ),
      ],
    );
  }
}
