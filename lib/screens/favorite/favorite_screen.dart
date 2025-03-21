import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/favorite/favorite_local_database_provider.dart';
import 'package:restaurant_app/static/favorite_list_result_state.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/widgets/restaurant_card_widget.dart';
import 'package:restaurant_app/widgets/restaurant_error_widget.dart';
import 'package:restaurant_app/widgets/restaurant_loading_indicator_widget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();

    final localDatabaseProvider = context.read<FavoriteLocalDatabaseProvider>();

    Future.microtask(() {
      localDatabaseProvider.loadAllRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<FavoriteLocalDatabaseProvider>().loadAllRestaurant();
        },
        child: Consumer<FavoriteLocalDatabaseProvider>(
          builder: (context, value, _) {
            switch (value.listResultState) {
              case FavoriteListLoadingState():
                return RestaurantLoadingIndicatorWidget();
              case FavoriteListLoadedState(data: var restaurants):
                if (restaurants.isEmpty) {
                  return RestaurantErrorWidget(
                    message: 'No favorite restaurant yet',
                  );
                }

                return ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];

                    return RestaurantCardWidget(
                      restaurant: restaurant,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          NavigationRoute.detailRoute.name,
                          arguments: {
                            'restaurant': restaurant.toJson(),
                          },
                        );
                      },
                    );
                  },
                );
              case FavoriteListErrorState(error: var message):
                return RestaurantErrorWidget(message: message);
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
