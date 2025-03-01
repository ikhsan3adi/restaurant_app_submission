import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/static/favorite_list_result_state.dart';
import 'package:restaurant_app/static/favorite_operation_result_state.dart';
import 'package:restaurant_app/utils/error_handler.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  FavoriteListResultState _listResultState = FavoriteListNoneState();
  FavoriteListResultState get listResultState => _listResultState;

  FavoriteOperationResultState _operationResultState =
      FavoriteOperationNoneState();
  FavoriteOperationResultState get operationResultState =>
      _operationResultState;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> loadAllRestaurant() async {
    try {
      _listResultState = FavoriteListLoadingState();
      notifyListeners();

      final result = await _service.getAllItems();
      _listResultState = FavoriteListLoadedState(result);
      _restaurant = null;
    } catch (e) {
      _listResultState = FavoriteListErrorState(ErrorHandler.handleError(e));
    }
    notifyListeners();
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
    } catch (e) {
      _operationResultState = FavoriteOperationErrorState(
        ErrorHandler.handleError(e),
      );
    }
    notifyListeners();
  }

  Future<void> saveRestaurant(Restaurant value) async {
    try {
      _operationResultState = FavoriteOperationLoadingState();
      notifyListeners();

      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _operationResultState = FavoriteOperationErrorState(
          'Failed to save favorite restaurant.',
        );
      } else {
        _operationResultState = FavoriteOperationSuccessState(
          'Restaurant added to favorite!',
        );
      }
    } catch (e) {
      _operationResultState = FavoriteOperationErrorState(
        ErrorHandler.handleError(e),
      );
    }
    notifyListeners();
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      _operationResultState = FavoriteOperationLoadingState();
      notifyListeners();

      await _service.removeItem(id);
      _restaurant = null;

      _operationResultState = FavoriteOperationSuccessState(
        'Restaurant removed from favorite.',
      );
    } catch (e) {
      _operationResultState = FavoriteOperationErrorState(
        ErrorHandler.handleError(e),
      );
    }
    notifyListeners();
  }

  bool checkItemFavourite(String id) {
    final sameRestaurant = _restaurant?.id == id;
    return sameRestaurant;
  }
}
