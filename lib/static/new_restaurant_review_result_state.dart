import 'package:restaurant_app/data/model/restaurant_detail/restaurant_customer_review.dart';

sealed class NewRestaurantReviewResultState {}

class NewRestaurantReviewNoneState extends NewRestaurantReviewResultState {}

class NewRestaurantReviewLoadingState extends NewRestaurantReviewResultState {}

class NewRestaurantReviewErrorState extends NewRestaurantReviewResultState {
  final String error;

  NewRestaurantReviewErrorState(this.error);
}

class NewRestaurantReviewLoadedState extends NewRestaurantReviewResultState {
  final List<RestaurantCustomerReview> data;

  NewRestaurantReviewLoadedState(this.data);
}
