import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(this._apiServices);

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  // TODO: fix method name?
  Future<void> searchRestaurant(String query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantSearchResult(query);

      if (result.error) {
        //! TODO: Missing error message
        _resultState = RestaurantSearchErrorState('');
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
