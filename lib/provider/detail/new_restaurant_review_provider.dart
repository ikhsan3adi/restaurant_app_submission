import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/new_restaurant_review.dart';
import 'package:restaurant_app/static/new_restaurant_review_result_state.dart';

class NewRestaurantReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  NewRestaurantReviewProvider(this._apiServices);

  NewRestaurantReviewResultState _resultState = NewRestaurantReviewNoneState();

  NewRestaurantReviewResultState get resultState => _resultState;

  Future<void> addNewRestaurantReview(NewRestaurantReview review) async {
    try {
      _resultState = NewRestaurantReviewLoadingState();
      notifyListeners();

      final result = await _apiServices.postRestaurantReview(review);

      if (result.error) {
        _resultState = NewRestaurantReviewErrorState(result.message);
        notifyListeners();
        return;
      }

      _resultState = NewRestaurantReviewSuccessState(result.customerReviews);
      notifyListeners();
    } on Exception catch (e) {
      _resultState = NewRestaurantReviewErrorState(e.toString());
      notifyListeners();
    }
  }
}
