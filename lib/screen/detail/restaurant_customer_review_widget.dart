import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_detail.dart';
import 'package:restaurant_app/screen/detail/review_card_widget.dart';

class RestaurantCustomerReviewWidget extends StatelessWidget {
  const RestaurantCustomerReviewWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 8),
      sliver: SliverList.builder(
        itemCount: restaurant.customerReviews.length,
        itemBuilder: (context, index) {
          final review = restaurant.customerReviews[index];
          return ReviewCardWidget(review: review);
        },
      ),
    );
  }
}
