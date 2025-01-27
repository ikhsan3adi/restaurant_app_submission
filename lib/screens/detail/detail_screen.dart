import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/providers/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screens/detail/add_review_button.dart';
import 'package:restaurant_app/screens/detail/detail_screen_app_bar.dart';
import 'package:restaurant_app/screens/detail/restaurant_customer_reviews.dart';
import 'package:restaurant_app/screens/detail/restaurant_menus.dart';
import 'package:restaurant_app/screens/detail/restaurant_normal_header.dart';
import 'package:restaurant_app/screens/detail/restaurant_title_header.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/widgets/restaurant_categories_widget.dart';
import 'package:restaurant_app/widgets/restaurant_description_widget.dart';
import 'package:restaurant_app/widgets/restaurant_error_widget.dart';
import 'package:restaurant_app/widgets/restaurant_loading_indicator_widget.dart';

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
    return Scaffold(
      floatingActionButton: AddReviewButton(),
      body: CustomScrollView(
        slivers: [
          DetailScreenAppBar(
            pictureId: widget.restaurant.pictureId,
            imageHeroTag: widget.imageHeroTag ?? widget.restaurant.pictureId,
          ),
          RestaurantTitleHeader(
            restaurant: widget.restaurant,
            titleHeroTag: widget.titleHeroTag ?? widget.restaurant.id,
          ),
          Consumer<RestaurantDetailProvider>(
            builder: (context, value, _) => switch (value.resultState) {
              RestaurantDetailLoadingState() => SliverFillRemaining(
                  child: RestaurantLoadingIndicatorWidget(),
                ),
              RestaurantDetailErrorState(error: var message) =>
                SliverFillRemaining(
                  child: RestaurantErrorWidget(message: message),
                ),
              RestaurantDetailLoadedState(data: var restaurant) =>
                SliverList.list(
                  children: [
                    RestaurantCategoriesWidget(restaurant: restaurant),
                    RestaurantDescriptionWidget(restaurant: restaurant),
                  ],
                ),
              _ => SliverToBoxAdapter(),
            },
          ),
          _sectionDivider(),
          RestaurantNormalHeader(text: 'Menus'),
          _subtitle(context, text: 'Foods'),
          Consumer<RestaurantDetailProvider>(
            builder: (context, value, _) => switch (value.resultState) {
              RestaurantDetailLoadedState(data: var restaurant) =>
                RestaurantMenus(menus: restaurant.menus.foods),
              _ => SliverToBoxAdapter(),
            },
          ),
          _sectionDivider(
            padding: const EdgeInsets.symmetric(horizontal: 128),
          ),
          _subtitle(context, text: 'Drinks'),
          Consumer<RestaurantDetailProvider>(
            builder: (context, value, _) => switch (value.resultState) {
              RestaurantDetailLoadedState(data: var restaurant) =>
                RestaurantMenus(menus: restaurant.menus.drinks),
              _ => SliverToBoxAdapter(),
            },
          ),
          _sectionDivider(),
          RestaurantNormalHeader(text: 'Reviews'),
          Consumer<RestaurantDetailProvider>(
            builder: (context, value, _) => switch (value.resultState) {
              RestaurantDetailLoadedState(data: var restaurant) =>
                RestaurantCustomerReviews(restaurant: restaurant),
              _ => SliverToBoxAdapter(),
            },
          ),
        ],
      ),
    );
  }

  Widget _subtitle(
    BuildContext context, {
    required String text,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(text, style: textTheme.titleMedium),
      ),
    );
  }

  Widget _sectionDivider({
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
  }) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: padding,
        child: Divider(),
      ),
    );
  }
}
