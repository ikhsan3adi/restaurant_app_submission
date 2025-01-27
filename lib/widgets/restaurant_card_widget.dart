import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/restaurant_image_widget.dart';

class RestaurantCardWidget extends StatelessWidget {
  const RestaurantCardWidget({
    super.key,
    required this.restaurant,
    required this.onPressed,
    this.imageHeroTag,
    this.titleHeroTag,
  });

  final Restaurant restaurant;
  final VoidCallback onPressed;
  final Object? imageHeroTag;
  final Object? titleHeroTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Hero(
                tag: imageHeroTag ?? restaurant.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: RestaurantImageWidget.small(
                    pictureId: restaurant.pictureId,
                    width: 144,
                    height: 128,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Hero(
                      tag: titleHeroTag ?? restaurant.id,
                      child: Text(
                        restaurant.name,
                        style: textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: theme.colorScheme.primary,
                        ),
                        Flexible(
                          child: Text(
                            restaurant.city,
                            style: textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: theme.colorScheme.tertiary,
                        ),
                        Flexible(
                          child: Text(
                            restaurant.rating.toString(),
                            style: textTheme.bodyMedium?.copyWith(
                              color: restaurant.rating >= 5.0
                                  ? theme.colorScheme.tertiary
                                  : theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
