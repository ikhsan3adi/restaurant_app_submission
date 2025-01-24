import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/screen/home/home_screen_app_bar_widget.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/screen/home/restaurant_info_tile_widget.dart';
import 'package:restaurant_app/screen/home/restaurant_list_error_widget.dart';
import 'package:restaurant_app/screen/home/restaurant_list_loading_indicator_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final restaurantListProvider = context.read<RestaurantListProvider>();

    Future.microtask(() {
      restaurantListProvider.fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<RestaurantListProvider>().fetchRestaurantList();
        },
        child: CustomScrollView(
          slivers: [
            HomeScreenAppBarWidget(),
            SliverToBoxAdapter(child: RestaurantInfoTileWidget()),
            Consumer<RestaurantListProvider>(
              builder: (context, value, _) {
                return switch (value.resultState) {
                  RestaurantListLoadingState() => SliverFillRemaining(
                      child: RestaurantListLoadingIndicatorWidget(),
                    ),
                  RestaurantListErrorState(error: var message) =>
                    SliverFillRemaining(
                      child: RestaurantListErrorWidget(message: message),
                    ),
                  RestaurantListLoadedState(data: var restaurants) =>
                    SliverList.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];

                        return RestaurantCardWidget(
                          restaurant: restaurant,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              NavigationRoute.detailRoute.name,
                              arguments: restaurant.id,
                            );
                          },
                        );
                      },
                    ),
                  _ => SliverToBoxAdapter(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
