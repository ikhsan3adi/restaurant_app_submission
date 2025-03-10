import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/restaurant_card_widget.dart';
import 'package:restaurant_app/widgets/restaurant_image_widget.dart';

void main() {
  late Widget widget;
  const dummyRestaurant = Restaurant(
    id: '1',
    name: 'Test Restaurant',
    description: 'test',
    pictureId: '16',
    city: 'Test City',
    rating: 5.0,
  );

  setUp(() {
    widget = MaterialApp(
      home: Scaffold(
        body: RestaurantCardWidget(
          restaurant: dummyRestaurant,
          onPressed: () {},
        ),
      ),
    );
  });

  group('restaurant card widget', () {
    testWidgets(
      'have a Text widget for restaurant name & city',
      (tester) async {
        await tester.pumpWidget(widget);

        final titleFinder = find.text('Test Restaurant');
        final cityFinder = find.text('Test City');

        expect(titleFinder, findsOneWidget);
        expect(cityFinder, findsOneWidget);
      },
    );

    testWidgets(
      'have a Text & Icon widget for restaurant rating',
      (tester) async {
        await tester.pumpWidget(widget);

        final ratingFinder = find.text('5.0');
        final starFinder = find.byIcon(Icons.star);

        expect(ratingFinder, findsOneWidget);
        expect(starFinder, findsOneWidget);
      },
    );

    testWidgets(
      'have a Text with styles',
      (tester) async {
        await tester.pumpWidget(widget);

        final titleFinder = find.text('Test Restaurant');
        final titleWidget = tester.widget<Text>(titleFinder);
        final cityFinder = find.text('Test City');
        final cityWidget = tester.widget<Text>(cityFinder);
        final ratingTextFinder = find.text('5.0');
        final ratingTextWidget = tester.widget<Text>(ratingTextFinder);

        expect(
            titleWidget.style?.fontSize,
            Theme.of(tester.element(titleFinder))
                .textTheme
                .titleLarge
                ?.fontSize);
        expect(
            titleWidget.style?.fontWeight,
            Theme.of(tester.element(titleFinder))
                .textTheme
                .titleLarge
                ?.fontWeight);
        expect(titleWidget.maxLines, 2);
        expect(titleWidget.overflow, TextOverflow.ellipsis);

        expect(
            cityWidget.style?.fontSize,
            Theme.of(tester.element(cityFinder))
                .textTheme
                .bodyMedium
                ?.fontSize);
        expect(
            cityWidget.style?.fontWeight,
            Theme.of(tester.element(cityFinder))
                .textTheme
                .bodyMedium
                ?.fontWeight);
        expect(cityWidget.maxLines, 2);
        expect(cityWidget.overflow, TextOverflow.ellipsis);

        expect(
            ratingTextWidget.style?.fontSize,
            Theme.of(tester.element(ratingTextFinder))
                .textTheme
                .bodyMedium
                ?.fontSize);
        expect(
            ratingTextWidget.style?.fontWeight,
            Theme.of(tester.element(ratingTextFinder))
                .textTheme
                .titleLarge
                ?.fontWeight);
        expect(ratingTextWidget.maxLines, 1);
      },
    );

    testWidgets(
      'have a Container with styles',
      (tester) async {
        await tester.pumpWidget(widget);

        final containerFinder = find.byWidgetPredicate((widget) {
          if (widget is Container) {
            final decoration = widget.decoration as BoxDecoration?;
            return decoration?.borderRadius == BorderRadius.circular(20);
          }
          return false;
        });

        expect(containerFinder, findsOneWidget);
      },
    );

    testWidgets(
      'have a RestaurantImageWidget with styles for restaurant image',
      (tester) async {
        await tester.pumpWidget(widget);

        final imageFinder = find.byType(RestaurantImageWidget);

        expect(imageFinder, findsOneWidget);

        final imageWidget = tester.widget<RestaurantImageWidget>(imageFinder);

        expect(imageWidget.width, equals(144));
        expect(imageWidget.height, equals(128));
        expect(imageWidget.pictureId, equals(dummyRestaurant.pictureId));
      },
    );

    testWidgets('should call onPressed when tapped', (tester) async {
      bool isPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestaurantCardWidget(
              restaurant: dummyRestaurant,
              onPressed: () {
                isPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(RestaurantCardWidget));
      await tester.pump();

      expect(isPressed, isTrue);
    });
  });
}
