import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/enum/image_size.dart';
import 'package:restaurant_app/providers/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/providers/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/widgets/favorite_icon_widget.dart';
import 'package:restaurant_app/widgets/restaurant_image_widget.dart';

class DetailScreenAppBar extends StatelessWidget {
  const DetailScreenAppBar({
    super.key,
    required this.pictureId,
    required this.imageHeroTag,
  });

  final String pictureId;
  final Object imageHeroTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: MediaQuery.of(context).size.width * 9 / 13,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: imageHeroTag,
          child: RestaurantImageWidget.large(
            pictureId: pictureId,
            fadeInDuration: Duration.zero,
            placeholder: CachedNetworkImage(
              imageUrl: ApiServices.restaurantImageUrl(
                pictureId,
                ImageSize.small,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      leading: IconButton.filled(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            theme.colorScheme.surfaceContainerHigh,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: [
        ChangeNotifierProvider(
          create: (_) => FavoriteIconProvider(),
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, value, _) {
              return switch (value.resultState) {
                RestaurantDetailLoadedState(data: var restaurant) =>
                  FavoriteIconWidget(restaurantDetail: restaurant),
                _ => SizedBox(),
              };
            },
          ),
        ),
      ],
    );
  }
}
