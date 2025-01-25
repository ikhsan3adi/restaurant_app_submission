import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/util/sliver_header_delegate.dart';

class RestaurantTitleHeader extends StatelessWidget {
  const RestaurantTitleHeader({
    super.key,
    required this.restaurant,
    required this.titleHeroTag,
  });

  final Restaurant restaurant;
  final Object titleHeroTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        minHeight: 90,
        maxHeight: 90,
        child: Container(
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Hero(
                tag: titleHeroTag,
                child: Text(
                  restaurant.name,
                  style: textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Icon(Icons.location_pin),
                    Flexible(
                      child: Consumer<RestaurantDetailProvider>(
                        builder: (context, value, _) {
                          return switch (value.resultState) {
                            RestaurantDetailLoadedState(data: var detail) =>
                              Text(
                                '${detail.address}, ${detail.city}',
                                style: textTheme.bodyMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            _ => Text(
                                restaurant.city,
                                style: textTheme.bodyMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          };
                        },
                      ),
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
