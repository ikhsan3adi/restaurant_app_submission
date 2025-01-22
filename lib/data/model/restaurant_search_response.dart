import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantSearchResponse {
  final bool error;
  //? TODO: missing message?
  // final String? message;
  final int founded;
  final List<Restaurant> restaurants;

  const RestaurantSearchResponse({
    required this.error,
    // this.message,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantSearchResponse(
      error: json['error'],
      // message: json['message'],
      founded: json['founded'],
      restaurants: List<Restaurant>.from(
        json['restaurants'].map((x) => Restaurant.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        // 'message': message,
        'founded': founded,
        'restaurants': List<dynamic>.from(
          restaurants.map((x) => x.toJson()),
        ),
      };
}
