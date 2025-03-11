import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/widgets/restaurant_card_widget.dart';

import 'base_robot.dart';

class SearchRobot extends BaseRobot {
  SearchRobot(super.tester);

  Future<void> searchRestaurant(String text) async {
    final textFieldFinder = find.byKey(const ValueKey('search_text_field'));
    final searchButtonFinder = find.byKey(const ValueKey('search_button'));

    await enterText(textFieldFinder, text);
    await tap(searchButtonFinder);
  }

  Future<void> tapFirstRestaurant() async {
    await tap(find.byType(RestaurantCardWidget).first);
  }

  Future<void> verifySearchList() async {
    expect(find.byType(SliverList), findsOneWidget);
    expect(find.byType(RestaurantCardWidget), findsWidgets);
  }

  Future<void> tapBackButton() async {
    await tap(find.byIcon(Icons.arrow_back));
  }
}
