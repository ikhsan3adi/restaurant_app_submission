import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_detail.dart';

sealed class RestaurantDetailResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RestaurantDetailNoneState extends RestaurantDetailResultState {}

class RestaurantDetailLoadingState extends RestaurantDetailResultState {}

class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String error;

  RestaurantDetailErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class RestaurantDetailLoadedState extends RestaurantDetailResultState {
  final RestaurantDetail data;

  RestaurantDetailLoadedState(this.data);

  @override
  List<Object?> get props => [data];
}
