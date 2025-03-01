import 'package:restaurant_app/data/model/restaurant_detail/restaurant_detail.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
      };

  factory Restaurant.fromDbMap(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['picture_id'],
      city: json['city'],
      rating: json['rating']?.toDouble(),
    );
  }

  Map<String, dynamic> toDbMap() => {
        'id': id,
        'name': name,
        'description': description,
        'picture_id': pictureId,
        'city': city,
        'rating': rating,
      };

  factory Restaurant.fromDetail(RestaurantDetail detail) {
    return Restaurant(
      id: detail.id,
      name: detail.name,
      description: detail.description,
      pictureId: detail.pictureId,
      city: detail.city,
      rating: detail.rating,
    );
  }
}
