import 'package:restaurant_app/data/model/restaurant.dart';

sealed class FavoriteListResultState {}

class FavoriteListNoneState extends FavoriteListResultState {}

class FavoriteListLoadingState extends FavoriteListResultState {}

class FavoriteListErrorState extends FavoriteListResultState {
  final String error;

  FavoriteListErrorState(this.error);
}

class FavoriteListLoadedState extends FavoriteListResultState {
  final List<Restaurant> data;

  FavoriteListLoadedState(this.data);
}
