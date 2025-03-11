import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/search/restaurant_search_provider.dart';
import 'package:restaurant_app/utils/debouncer.dart';

class SearchScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchScreenAppBar({super.key});

  @override
  State<SearchScreenAppBar> createState() => _SearchScreenAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchScreenAppBarState extends State<SearchScreenAppBar> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    _searchController.text = context.read<RestaurantSearchProvider>().query;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        key: const ValueKey('search_text_field'),
        autofocus: true,
        controller: _searchController,
        onChanged: (value) {
          _debouncer.call(() {
            context.read<RestaurantSearchProvider>().searchRestaurant(value);
          });
        },
        decoration: InputDecoration(
          hintText: 'Search restaurant',
          suffixIcon: IconButton(
            key: const ValueKey('search_button'),
            tooltip: 'Search Restaurant',
            onPressed: () {
              context
                  .read<RestaurantSearchProvider>()
                  .searchRestaurant(_searchController.text);
            },
            icon: Hero(
              tag: 'search-btn',
              child: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
