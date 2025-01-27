import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_menu.dart';
import 'package:restaurant_app/widgets/menu_card_widget.dart';

class RestaurantMenus extends StatelessWidget {
  const RestaurantMenus({
    super.key,
    required this.menus,
  });

  final List<RestaurantMenu> menus;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 4 / 3,
        ),
        itemCount: menus.length,
        itemBuilder: (context, index) {
          final menu = menus[index];
          return MenuCardWidget(menu: menu);
        },
      ),
    );
  }
}
