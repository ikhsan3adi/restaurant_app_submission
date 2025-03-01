import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_detail.dart';
import 'package:restaurant_app/providers/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/providers/favorite/favorite_local_database_provider.dart';
import 'package:restaurant_app/static/favorite_operation_result_state.dart';

class FavoriteIconWidget extends StatefulWidget {
  const FavoriteIconWidget({
    super.key,
    required this.restaurantDetail,
  });

  final RestaurantDetail restaurantDetail;

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  late final Restaurant restaurant;

  @override
  void initState() {
    super.initState();

    restaurant = Restaurant.fromDetail(widget.restaurantDetail);

    final localDatabaseProvider = context.read<FavoriteLocalDatabaseProvider>();
    final favIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantById(restaurant.id);
      favIconProvider.isFavorited = localDatabaseProvider.checkItemFavourite(
        restaurant.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton.filled(
      tooltip: context.watch<FavoriteIconProvider>().isFavorited
          ? 'Remove from favorite'
          : 'Add to favorite',
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          theme.colorScheme.surfaceContainerHigh,
        ),
      ),
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorited
            ? Icons.favorite
            : Icons.favorite_outline,
      ),
      onPressed: () async {
        final localDatabaseProvider =
            context.read<FavoriteLocalDatabaseProvider>();

        if (localDatabaseProvider.operationResultState
            is FavoriteOperationLoadingState) {
          return;
        }

        final favIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favIconProvider.isFavorited;
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        if (isFavorited) {
          await localDatabaseProvider.removeRestaurantById(
            restaurant.id,
          );
        } else {
          await localDatabaseProvider.saveRestaurant(restaurant);
        }

        scaffoldMessenger.clearSnackBars();

        switch (localDatabaseProvider.operationResultState) {
          case FavoriteOperationSuccessState(message: var message):
            favIconProvider.isFavorited = !isFavorited;
            scaffoldMessenger.showSnackBar(SnackBar(
              content: Text(message),
            ));
            break;
          case FavoriteOperationErrorState(error: var message):
            scaffoldMessenger.showSnackBar(SnackBar(
              content: Text(message),
            ));
            break;
          default:
        }

        await localDatabaseProvider.loadAllRestaurant();
      },
    );
  }
}
