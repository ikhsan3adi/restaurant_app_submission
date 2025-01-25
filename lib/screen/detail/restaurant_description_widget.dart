import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_detail.dart';

class RestaurantDescriptionWidget extends StatelessWidget {
  const RestaurantDescriptionWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text('Description', style: textTheme.titleMedium),
          Text(
            restaurant.description,
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
