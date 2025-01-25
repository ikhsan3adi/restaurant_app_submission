import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_detail.dart';

class RestaurantCategoriesWidget extends StatelessWidget {
  const RestaurantCategoriesWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: restaurant.categories.map((category) {
          return Chip(
            label: Text(category.name),
          );
        }).toList(),
      ),
    );
  }
}
