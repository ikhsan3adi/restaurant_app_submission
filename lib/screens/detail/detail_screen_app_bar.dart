import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/enum/image_size.dart';
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
    );
  }
}
