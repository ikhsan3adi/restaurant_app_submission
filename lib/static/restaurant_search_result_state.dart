import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

sealed class RestaurantSearchResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RestaurantSearchNoneState extends RestaurantSearchResultState {}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String error;

  RestaurantSearchErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<Restaurant> data;

  RestaurantSearchLoadedState(this.data);

  @override
  List<Object?> get props => [data];
}
