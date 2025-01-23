import 'package:flutter/material.dart';

class RestaurantListErrorWidget extends StatelessWidget {
  const RestaurantListErrorWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: 64,
          ),
          Text(
            message,
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
