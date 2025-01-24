import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/screen/home/restaurant_list_error_widget.dart';
import 'package:restaurant_app/screen/home/restaurant_list_loading_indicator_widget.dart';
import 'package:restaurant_app/screen/search/search_info_tile_widget.dart';
import 'package:restaurant_app/screen/search/search_screen_app_bar_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchScreenAppBarWidget(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SearchInfoTileWidget()),
          Consumer<RestaurantSearchProvider>(
            builder: (context, value, _) {
              return switch (value.resultState) {
                RestaurantSearchLoadingState() => SliverFillRemaining(
                    child: RestaurantListLoadingIndicatorWidget(),
                  ),
                RestaurantSearchErrorState(error: var message) =>
                  SliverFillRemaining(
                    child: RestaurantListErrorWidget(message: message),
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
                              'restaurantId': restaurant.id,
                              'pictureId': restaurant.pictureId,
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
              };
            },
          ),
        ],
      ),
    );
  }
}
