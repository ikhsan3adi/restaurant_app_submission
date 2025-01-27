import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/sliver_header_delegate.dart';

class RestaurantNormalHeader extends StatelessWidget {
  const RestaurantNormalHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        minHeight: 60,
        maxHeight: 60,
        child: Container(
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            style: textTheme.titleLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
