import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(this._apiServices);

  String _query = '';
  String get query => _query;

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();
  RestaurantSearchResultState get resultState => _resultState;

  Future<void> searchRestaurant(String query) async {
    try {
      _query = query;
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantSearchResult(query);

      if (result.error) {
        _resultState = RestaurantSearchErrorState('Unknown Error');
        notifyListeners();
        return;
      }

      _resultState = RestaurantSearchLoadedState(result.restaurants);
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }
}
