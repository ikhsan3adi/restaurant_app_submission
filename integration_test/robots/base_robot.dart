import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class BaseRobot {
  final WidgetTester tester;

  BaseRobot(this.tester);

  Future<void> loadUI(Widget widget) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }

  Future<void> tap(Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> enterText(Finder finder, String text) async {
    await tap(finder);
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  Future<void> drag(Finder finder, Offset offset) async {
    await tester.drag(finder, offset);
    await tester.pumpAndSettle();
  }
}
