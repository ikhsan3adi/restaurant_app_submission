import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/widgets/restaurant_card_widget.dart';

import 'base_robot.dart';

class FavoriteRobot extends BaseRobot {
  FavoriteRobot(super.tester);

  Future<void> verifyFavoriteList() async {
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(RestaurantCardWidget), findsOneWidget);
  }

  Future<void> verifyFavoriteListEmpty() async {
    expect(find.byType(ListView), findsNWidgets(0));
    expect(find.byType(RestaurantCardWidget), findsNWidgets(0));
  }

  Future<void> tapFirstRestaurant() async {
    await tap(find.byType(RestaurantCardWidget).first);
  }

  Future<void> goToHomePage() async {
    await tap(find.byKey(const ValueKey('nav_home_button')));
  }
}
