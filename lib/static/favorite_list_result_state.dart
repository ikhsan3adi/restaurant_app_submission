import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

sealed class FavoriteListResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteListNoneState extends FavoriteListResultState {}

class FavoriteListLoadingState extends FavoriteListResultState {}

class FavoriteListErrorState extends FavoriteListResultState {
  final String error;

  FavoriteListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class FavoriteListLoadedState extends FavoriteListResultState {
  final List<Restaurant> data;

  FavoriteListLoadedState(this.data);

  @override
  List<Object?> get props => [data];
}
