import 'package:flutter/material.dart';

class RestaurantLoadingIndicatorWidget extends StatelessWidget {
  const RestaurantLoadingIndicatorWidget({
    super.key,
    this.text = 'Please wait...',
  });

  final String text;

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
            text,
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
