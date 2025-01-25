import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/enum/image_size.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

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
                  child: Image.network(
                    ApiServices.restaurantImageUrl(
                      restaurant.pictureId,
                      ImageSize.small,
                    ),
                    fit: BoxFit.cover,
                    width: 144,
                    height: 128,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.errorContainer,
                        ),
                        width: 144,
                        height: 128,
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 56,
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      );
                    },
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
