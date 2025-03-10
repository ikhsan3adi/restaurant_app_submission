import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

sealed class RestaurantListResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  RestaurantListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class RestaurantListLoadedState extends RestaurantListResultState {
  final List<Restaurant> data;

  RestaurantListLoadedState(this.data);

  @override
  List<Object?> get props => [data];
}
