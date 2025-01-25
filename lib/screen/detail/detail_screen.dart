import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen_app_bar_widget.dart';
import 'package:restaurant_app/screen/detail/restaurant_description_widget.dart';
import 'package:restaurant_app/screen/detail/restaurant_normal_header.dart';
import 'package:restaurant_app/screen/detail/restaurant_title_header.dart';
import 'package:restaurant_app/screen/home/restaurant_list_error_widget.dart';
import 'package:restaurant_app/screen/home/restaurant_list_loading_indicator_widget.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.restaurant,
    this.imageHeroTag,
    this.titleHeroTag,
  });

  final Restaurant restaurant;
  final Object? imageHeroTag;
  final Object? titleHeroTag;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    final restaurantListProvider = context.read<RestaurantDetailProvider>();

    Future.microtask(() {
      restaurantListProvider.fetchRestaurantDetail(widget.restaurant.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DetailScreenAppBarWidget(
            pictureId: widget.restaurant.pictureId,
            imageHeroTag: widget.imageHeroTag ?? widget.restaurant.pictureId,
          ),
          RestaurantTitleHeader(
            restaurant: widget.restaurant,
            titleHeroTag: widget.titleHeroTag ?? widget.restaurant.id,
          ),
          Consumer<RestaurantDetailProvider>(
            builder: (context, value, child) => switch (value.resultState) {
              RestaurantDetailLoadingState() => SliverFillRemaining(
                  child: RestaurantListLoadingIndicatorWidget(),
                ),
              RestaurantDetailErrorState(error: var message) =>
                SliverFillRemaining(
                  child: RestaurantListErrorWidget(message: message),
                ),
              RestaurantDetailLoadedState(data: var restaurant) =>
                SliverToBoxAdapter(
                  child: RestaurantDescriptionWidget(
                    description: restaurant.description,
                  ),
                ),
              _ => SliverToBoxAdapter(),
            },
          ),
          RestaurantNormalHeader(text: 'Menus'),
          // TODO: Menus
          RestaurantNormalHeader(text: 'Reviews'),
          // TODO: Reviews
        ],
      ),
    );
  }
}
