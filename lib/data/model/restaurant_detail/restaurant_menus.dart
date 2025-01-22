import 'package:restaurant_app/data/model/restaurant_detail/restaurant_menu.dart';

class RestaurantMenus {
  final List<RestaurantMenu> foods;
  final List<RestaurantMenu> drinks;

  const RestaurantMenus({
    required this.foods,
    required this.drinks,
  });

  factory RestaurantMenus.fromJson(Map<String, dynamic> json) {
    return RestaurantMenus(
      foods: List<RestaurantMenu>.from(
        json['foods'].map((x) => RestaurantMenu.fromJson(x)),
      ),
      drinks: List<RestaurantMenu>.from(
        json['drinks'].map((x) => RestaurantMenu.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'foods': List<dynamic>.from(foods.map((x) => x.toJson())),
        'drinks': List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
