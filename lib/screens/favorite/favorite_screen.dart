import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/favorite/local_database_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/widgets/restaurant_card_widget.dart';
import 'package:restaurant_app/widgets/restaurant_error_widget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();

    final localDatabaseProvider = context.read<LocalDatabaseProvider>();

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
          context.read<LocalDatabaseProvider>().loadAllRestaurant();
        },
        child: Consumer<LocalDatabaseProvider>(
          builder: (context, value, _) {
            final restaurants = value.restaurantList ?? [];

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
          },
        ),
      ),
    );
  }
}
