import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/util/debouncer.dart';

class SearchScreenAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const SearchScreenAppBarWidget({super.key});

  @override
  State<SearchScreenAppBarWidget> createState() =>
      _SearchScreenAppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchScreenAppBarWidgetState extends State<SearchScreenAppBarWidget> {
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
        autofocus: true,
        controller: _searchController,
        onChanged: (value) {
          _debouncer.call(() {
            context.read<RestaurantSearchProvider>().searchRestaurant(value);
          });
        },
        decoration: InputDecoration(
          hintText: 'Search restaurant',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: IconButton(
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
