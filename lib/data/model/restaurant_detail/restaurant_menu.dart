import 'package:restaurant_app/data/enum/restaurant_menu_type.dart';

class RestaurantMenu {
  final String name;
  final RestaurantMenuType type;

  const RestaurantMenu({
    required this.name,
    this.type = RestaurantMenuType.food,
  });

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) {
    return RestaurantMenu(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
