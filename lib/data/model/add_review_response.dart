import 'package:restaurant_app/data/model/restaurant_detail/restaurant_customer_review.dart';

class AddReviewResponse {
  final bool error;
  final String message;
  final List<RestaurantCustomerReview> customerReviews;

  const AddReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory AddReviewResponse.fromJson(Map<String, dynamic> json) {
    return AddReviewResponse(
      error: json['error'],
      message: json['message'],
      customerReviews: List<RestaurantCustomerReview>.from(
        json['customerReviews'].map(
          (x) => RestaurantCustomerReview.fromJson(x),
        ),
      ),
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
