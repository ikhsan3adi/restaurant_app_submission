import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/app.dart';

import 'robots/detail_robot.dart';
import 'robots/favorite_robot.dart';
import 'robots/home_robot.dart';
import 'robots/search_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integration all feature', (tester) async {
    final app = await App.create();

    final homeRobot = HomeRobot(tester);
    final detailRobot = DetailRobot(tester);
    final favoriteRobot = FavoriteRobot(tester);
    final searchRobot = SearchRobot(tester);

    // home page
    await homeRobot.loadUI(app);
    await homeRobot.verifyRestaurantList();
    await homeRobot.dragToRefresh();
    await homeRobot.tapFirstRestaurant();

    // detail page
    await detailRobot.tapFavoriteButton();
    await detailRobot.verifyFavoriteButtonFavorited();
    await detailRobot.tapReviewButton();
    await detailRobot.addReview();
    await detailRobot.tapBackButton();

    // favorite page
    await homeRobot.goToFavoritePage();
    await favoriteRobot.verifyFavoriteList();
    await favoriteRobot.tapFirstRestaurant();
    // favorite detail page
    await detailRobot.tapFavoriteButton();
    await detailRobot.verifyFavoriteButtonUnfavorited();
    await detailRobot.tapBackButton();
    await favoriteRobot.verifyFavoriteListEmpty();
    await favoriteRobot.goToHomePage();

    // search page
    await homeRobot.goToSearchPage();
    await searchRobot.searchRestaurant('Kopi');
    await searchRobot.verifySearchList();
    await searchRobot.tapFirstRestaurant();
    await detailRobot.tapBackButton();
    await searchRobot.tapBackButton();
  });
}
