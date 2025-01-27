import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/search/restaurant_search_provider.dart';
import 'package:restaurant_app/screens/search/search_screen_app_bar.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';
import 'package:restaurant_app/widgets/restaurant_card_widget.dart';
import 'package:restaurant_app/widgets/restaurant_error_widget.dart';
import 'package:restaurant_app/widgets/restaurant_loading_indicator_widget.dart';
import 'package:restaurant_app/widgets/search_info_tile_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchScreenAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SearchInfoTileWidget()),
          Consumer<RestaurantSearchProvider>(
            builder: (context, value, _) => switch (value.resultState) {
              RestaurantSearchLoadingState() => SliverFillRemaining(
                  child: RestaurantLoadingIndicatorWidget(),
                ),
              RestaurantSearchErrorState(error: var message) =>
                SliverFillRemaining(
                  child: RestaurantErrorWidget(message: message),
                ),
              RestaurantSearchLoadedState(data: var restaurants) =>
                SliverList.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
                    final imageHeroTag = '${restaurant.pictureId}-search';
                    final titleHeroTag = '${restaurant.id}-search';

                    return RestaurantCardWidget(
                      restaurant: restaurant,
                      imageHeroTag: imageHeroTag,
                      titleHeroTag: titleHeroTag,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          NavigationRoute.detailRoute.name,
                          arguments: {
                            'restaurant': restaurant.toJson(),
                            'imageHeroTag': imageHeroTag,
                            'titleHeroTag': titleHeroTag,
                          },
                        );
                      },
                    );
                  },
                ),
              _ => SliverFillRemaining(
                  hasScrollBody: false,
                  child: Icon(
                    Icons.search,
                    size: 64,
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                ),
            },
          ),
        ],
      ),
    );
  }
}
