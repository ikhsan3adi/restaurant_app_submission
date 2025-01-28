import 'package:restaurant_app/data/model/restaurant_detail/restaurant_customer_review.dart';

class NewRestaurantReviewResponse {
  final bool error;
  final String message;
  final List<RestaurantCustomerReview> customerReviews;

  const NewRestaurantReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory NewRestaurantReviewResponse.fromJson(Map<String, dynamic> json) {
    return NewRestaurantReviewResponse(
      error: json['error'],
      message: json['message'],
      customerReviews: json['customerReviews'] != null
          ? List<RestaurantCustomerReview>.from(
              json['customerReviews']
                  .map((x) => RestaurantCustomerReview.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'customerReviews': List<dynamic>.from(
          customerReviews.map((x) => x.toJson()),
        ),
      };
}
