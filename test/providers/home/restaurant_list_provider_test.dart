import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/providers/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/custom_exceptions.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:test/test.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late RestaurantListProvider restaurantListProvider;
  late ApiServices apiServices;

  final resultOfSuccess = RestaurantListResponse(
    error: false,
    count: 1,
    message: 'success',
    restaurants: [
      Restaurant(
        id: '1',
        name: 'Test',
        description: 'test',
        pictureId: '16',
        city: 'Bandung',
        rating: 5.0,
      ),
    ],
  );
  final resultOfError = AppException('Failed to load restaurant list.');

  setUp(() {
    apiServices = MockApiServices();
    restaurantListProvider = RestaurantListProvider(apiServices);
  });

  group('restaurant list provider', () {
    test(
      'should return RestaurantListNoneState type when provider initialize.',
      () {
        final state = restaurantListProvider.resultState;

        expect(state, isA<RestaurantListNoneState>());
      },
    );

    test(
      'should return RestaurantListLoadedState type when API data retrieval is successful.',
      () async {
        // Arrange
        when(() => apiServices.getRestaurantList())
            .thenAnswer((_) async => resultOfSuccess);

        // Action
        await restaurantListProvider.fetchRestaurantList();
        final state = restaurantListProvider.resultState;

        // Assert
        expect(state, isA<RestaurantListLoadedState>());
      },
    );

    test(
      'should return restaurant list when API data retrieval is successful.',
      () async {
        // Arrange
        when(() => apiServices.getRestaurantList())
            .thenAnswer((_) async => resultOfSuccess);

        // Action
        await restaurantListProvider.fetchRestaurantList();
        final state = restaurantListProvider.resultState;

        // Assert
        expect(
          state,
          equals(RestaurantListLoadedState(resultOfSuccess.restaurants)),
        );
      },
    );

    test(
      'should return RestaurantListErrorState type when API data retrieval is failed.',
      () async {
        // Arrange
        when(() => apiServices.getRestaurantList()).thenThrow(resultOfError);

        // Action
        await restaurantListProvider.fetchRestaurantList();
        final state = restaurantListProvider.resultState;

        // Assert
        expect(state, isA<RestaurantListErrorState>());
      },
    );

    test(
      'should return "Failed to load restaurant list." type when API data retrieval is failed.',
      () async {
        // Arrange
        when(() => apiServices.getRestaurantList()).thenThrow(resultOfError);

        // Action
        await restaurantListProvider.fetchRestaurantList();
        final state = restaurantListProvider.resultState;

        // Assert
        expect(
          state,
          equals(RestaurantListErrorState('Failed to load restaurant list.')),
        );
      },
    );
  });
}
