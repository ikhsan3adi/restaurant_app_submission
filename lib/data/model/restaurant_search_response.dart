import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantSearchResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  const RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantSearchResponse(
      error: json['error'],
      founded: json['founded'],
      restaurants: List<Restaurant>.from(
        json['restaurants'].map((x) => Restaurant.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'founded': founded,
        'restaurants': List<dynamic>.from(
          restaurants.map((x) => x.toJson()),
        ),
      };
}
