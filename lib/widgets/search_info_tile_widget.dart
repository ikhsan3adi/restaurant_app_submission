import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/search/restaurant_search_provider.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class SearchInfoTileWidget extends StatelessWidget {
  const SearchInfoTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, value, _) {
          final state = value.resultState;
          return Container(
            decoration: BoxDecoration(
              color: _getBackgroundColorByState(context, state),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(
                _getIconByState(state),
                color: _getForegroundColorByState(context, state),
              ),
              textColor: _getForegroundColorByState(context, state),
              titleTextStyle: textTheme.bodyMedium,
              title: Text(_getTextByState(state)),
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColorByState(
    BuildContext context,
    RestaurantSearchResultState state,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (state) {
      RestaurantSearchNoneState() => colorScheme.surfaceContainer,
      RestaurantSearchLoadingState() => colorScheme.surfaceContainer,
      RestaurantSearchErrorState() => colorScheme.errorContainer,
      RestaurantSearchLoadedState() => colorScheme.tertiaryContainer,
    };
  }

  Color _getForegroundColorByState(
    BuildContext context,
    RestaurantSearchResultState state,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (state) {
      RestaurantSearchNoneState() => colorScheme.onSurface,
      RestaurantSearchLoadingState() => colorScheme.onSurface,
      RestaurantSearchErrorState() => colorScheme.onErrorContainer,
      RestaurantSearchLoadedState() => colorScheme.onTertiaryContainer,
    };
  }

  IconData _getIconByState(RestaurantSearchResultState state) {
    return switch (state) {
      RestaurantSearchNoneState() => Icons.search,
      RestaurantSearchLoadingState() => Icons.search,
      RestaurantSearchErrorState() => Icons.error_outline,
      RestaurantSearchLoadedState(data: var restaurants) =>
        restaurants.isEmpty ? Icons.close_outlined : Icons.restaurant_outlined,
    };
  }

  String _getTextByState(RestaurantSearchResultState state) {
    return switch (state) {
      RestaurantSearchNoneState() =>
        'Search restaurant by name, category, or menus',
      RestaurantSearchLoadingState() => 'Searching...',
      RestaurantSearchErrorState(error: var message) => message,
      RestaurantSearchLoadedState(data: var restaurants) => restaurants.isEmpty
          ? 'Restaurant not found!'
          : 'Found ${restaurants.length} restaurant(s)!',
    };
  }
}
