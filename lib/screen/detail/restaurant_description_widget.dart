import 'package:flutter/material.dart';

class RestaurantDescriptionWidget extends StatelessWidget {
  const RestaurantDescriptionWidget({
    super.key,
    required this.description,
  });

  final String description;

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
          Text('Description', style: textTheme.titleSmall),
          Text(
            description,
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
