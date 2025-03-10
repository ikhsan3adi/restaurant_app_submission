import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/providers/home/restaurant_list_provider.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/widgets/restaurant_card_widget.dart';
import 'package:restaurant_app/widgets/restaurant_error_widget.dart';
import 'package:restaurant_app/widgets/restaurant_info_tile_widget.dart';
import 'package:restaurant_app/widgets/restaurant_loading_indicator_widget.dart';

class MockRestaurantListProvider extends Mock
    implements RestaurantListProvider {}

void main() {
  late RestaurantListProvider restaurantListProvider;
  late Widget widget;

  setUp(() {
    restaurantListProvider = MockRestaurantListProvider();
    widget = MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => restaurantListProvider,
        child: HomeScreen(),
      ),
    );

    when(() => restaurantListProvider.fetchRestaurantList()).thenAnswer(
      (_) async {},
    );
  });

  group('home screen', () {
    testWidgets(
      'have every component, like SliverAppBar, RefreshIndicator,and CustomScrollView when first launch',
      (tester) async {
        when(() => restaurantListProvider.resultState)
            .thenReturn(RestaurantListNoneState());

        await tester.pumpWidget(widget);

        final appBarFinder = find.byType(SliverAppBar);
        final refreshIndicatorFinder = find.byType(RefreshIndicator);
        final customScrollViewFinder = find.byType(CustomScrollView);

        expect(appBarFinder, findsOneWidget);
        expect(refreshIndicatorFinder, findsOneWidget);
        expect(customScrollViewFinder, findsOneWidget);

        // check text in app bar
        final textInAppBarFinder = find.descendant(
          of: appBarFinder,
          matching: find.byType(Text),
        );
        final textInAppBar = tester.widget<Text>(textInAppBarFinder);
        expect(textInAppBar.data, 'QuickRestaurant');
      },
    );

    testWidgets(
      'have a RestaurantLoadingIndicatorWidget when restaurant list is loading',
      (tester) async {
        when(() => restaurantListProvider.resultState)
            .thenReturn(RestaurantListLoadingState());

        await tester.pumpWidget(widget);

        final loadingIndicatorFinder =
            find.byType(RestaurantLoadingIndicatorWidget);
        final circularProgressIndicatorFinder = find.descendant(
          of: loadingIndicatorFinder,
          matching: find.byType(CircularProgressIndicator),
        );
        final loadingTextFinder = find.descendant(
          of: loadingIndicatorFinder,
          matching: find.byType(Text),
        );
        final loadingText = tester.widget<Text>(loadingTextFinder);

        expect(loadingIndicatorFinder, findsOneWidget);
        expect(circularProgressIndicatorFinder, findsOneWidget);
        expect(loadingTextFinder, findsOneWidget);
        expect(loadingTextFinder, findsOneWidget);
        expect(loadingText.data, 'Please wait...');
      },
    );

    testWidgets(
      'have a RestaurantCardWidget & RestaurantInfoTileWidget when restaurant list is loaded',
      (tester) async {
        final resultOfSuccess = RestaurantListLoadedState(
          [
            Restaurant(
              id: '1',
              name: 'Test',
              description: 'test',
              pictureId: '16',
              city: 'Bandung',
              rating: 5.0,
            ),
            Restaurant(
              id: '2',
              name: 'Test 2',
              description: 'test 2',
              pictureId: '16',
              city: 'Bandung',
              rating: 5.0,
            ),
          ],
        );

        when(() => restaurantListProvider.resultState)
            .thenReturn(resultOfSuccess);

        await tester.pumpWidget(widget);

        final restaurantCardFinder = find.byType(RestaurantCardWidget);
        final restaurantInfoTileFinder = find.byType(RestaurantInfoTileWidget);
        final infoTileTextFinder = find.descendant(
          of: restaurantInfoTileFinder,
          matching: find.byType(Text),
        );
        final infoTileText = tester.widget<Text>(infoTileTextFinder);

        expect(restaurantCardFinder, findsNWidgets(2));
        expect(restaurantInfoTileFinder, findsOneWidget);
        expect(infoTileTextFinder, findsOneWidget);
        expect(infoTileText.data, 'Quick solutions for your restaurant needs.');
      },
    );

    testWidgets(
      'have a RestaurantErrorWidget when restaurant list is failed',
      (tester) async {
        final resultOfError = RestaurantListErrorState(
          'Failed to load restaurant list.',
        );

        when(() => restaurantListProvider.resultState)
            .thenReturn(resultOfError);

        await tester.pumpWidget(widget);

        final restaurantErrorFinder = find.byType(RestaurantErrorWidget);
        final restaurantErrorTextFinder = find.descendant(
          of: restaurantErrorFinder,
          matching: find.byType(Text),
        );
        final restaurantErrorText = tester.widget<Text>(
          restaurantErrorTextFinder,
        );

        expect(restaurantErrorFinder, findsOneWidget);
        expect(restaurantErrorTextFinder, findsOneWidget);
        expect(restaurantErrorText.data, 'Failed to load restaurant list.');
      },
    );

    testWidgets(
      'should call fetchRestaurantList when refresh indicator is pulled',
      (tester) async {
        when(() => restaurantListProvider.resultState)
            .thenReturn(RestaurantListLoadingState());

        await tester.pumpWidget(widget);

        final refreshIndicatorFinder = find.byType(RefreshIndicator);

        await tester.drag(
          refreshIndicatorFinder,
          const Offset(0, 100),
        );

        verify(() => restaurantListProvider.fetchRestaurantList()).called(1);
      },
    );
  });
}
