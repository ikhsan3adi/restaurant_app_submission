import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/widgets/review_card_widget.dart';
import 'base_robot.dart';

class DetailRobot extends BaseRobot {
  DetailRobot(super.tester);

  Future<void> tapFavoriteButton() async {
    await tap(find.byKey(const ValueKey('favorite_button')));
  }

  Future<void> verifyFavoriteButtonFavorited() async {
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  }

  Future<void> verifyFavoriteButtonUnfavorited() async {
    expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
  }

  Future<void> tapReviewButton() async {
    await tap(find.byKey(const ValueKey('add_review_button')));
  }

  Future<void> addReview() async {
    await enterText(
      find.byKey(const ValueKey('review_name_field')),
      'test123',
    );
    await enterText(
      find.byKey(const ValueKey('review_review_field')),
      'test review 123',
    );
    await tap(find.byKey(const ValueKey('submit_review_button')));
  }

  Future<void> verifyReviewSuccess() async {
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.byType(ReviewCardWidget), findsWidgets);
  }

  Future<void> tapBackButton() async {
    await tap(find.byKey(const ValueKey('detail_back_button')));
  }
}
