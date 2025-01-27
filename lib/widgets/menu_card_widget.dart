import 'package:flutter/material.dart';
import 'package:restaurant_app/data/enum/restaurant_menu_type.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_menu.dart';

class MenuCardWidget extends StatelessWidget {
  const MenuCardWidget({
    super.key,
    required this.menu,
  });

  final RestaurantMenu menu;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  menu.type == RestaurantMenuType.food
                      ? Icons.restaurant_menu_outlined
                      : Icons.coffee_outlined,
                  size: 64,
                  color: menu.type == RestaurantMenuType.food
                      ? theme.colorScheme.primary
                      : theme.colorScheme.tertiary,
                ),
              ),
            ),
          ),
          Text(
            menu.name,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
