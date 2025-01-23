import 'package:flutter/material.dart';

class RestaurantInfoTileWidget extends StatelessWidget {
  const RestaurantInfoTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SliverPadding(
      padding: EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Icon(
              Icons.restaurant_outlined,
              color: theme.colorScheme.onTertiaryContainer,
            ),
            textColor: theme.colorScheme.onTertiaryContainer,
            titleTextStyle: textTheme.bodyMedium,
            title: Text('Quick solutions for your restaurant needs.'),
          ),
        ),
      ),
    );
  }
}
