import 'package:flutter/material.dart';

class RestaurantLoadingIndicatorWidget extends StatelessWidget {
  const RestaurantLoadingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          CircularProgressIndicator(),
          Text(
            'Please wait...',
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
