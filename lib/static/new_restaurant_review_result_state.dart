import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_customer_review.dart';

sealed class NewRestaurantReviewResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewRestaurantReviewNoneState extends NewRestaurantReviewResultState {}

class NewRestaurantReviewLoadingState extends NewRestaurantReviewResultState {}

class NewRestaurantReviewErrorState extends NewRestaurantReviewResultState {
  final String error;

  NewRestaurantReviewErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class NewRestaurantReviewSuccessState extends NewRestaurantReviewResultState {
  final List<RestaurantCustomerReview> data;

  NewRestaurantReviewSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}
