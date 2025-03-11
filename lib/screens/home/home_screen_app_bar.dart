import 'package:flutter/material.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
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
          key: const ValueKey('search_page_button'),
          tooltip: 'Search Restaurant',
          onPressed: () {
            Navigator.pushNamed(context, NavigationRoute.searchRoute.name);
          },
          icon: Hero(
            tag: 'search-btn',
            child: Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
