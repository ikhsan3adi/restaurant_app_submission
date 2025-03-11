import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/widgets/restaurant_card_widget.dart';
import 'base_robot.dart';

class HomeRobot extends BaseRobot {
  HomeRobot(super.tester);

  Future<void> verifyRestaurantList() async {
    expect(find.byType(SliverList), findsOneWidget);
    expect(find.byType(RestaurantCardWidget), findsWidgets);
  }

  Future<void> tapFirstRestaurant() async {
    await tap(find.byType(RestaurantCardWidget).first);
  }

  Future<void> dragToRefresh() async {
    await drag(find.byType(RefreshIndicator), const Offset(0, 100));
  }

  Future<void> goToFavoritePage() async {
    await tap(find.byKey(const ValueKey('nav_favorite_button')));
  }

  Future<void> goToSearchPage() async {
    await tap(find.byKey(const ValueKey('search_page_button')));
  }
}
