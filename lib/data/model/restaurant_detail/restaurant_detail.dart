import 'package:restaurant_app/data/model/restaurant_detail/restaurant_category.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_customer_review.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant_menus.dart';

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<RestaurantCategory> categories;
  final RestaurantMenus menus;
  final double rating;
  final List<RestaurantCustomerReview> customerReviews;

  const RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      categories: List<RestaurantCategory>.from(
        json['categories'].map((x) => RestaurantCategory.fromJson(x)),
      ),
      menus: RestaurantMenus.fromJson(json['menus']),
      rating: json['rating']?.toDouble(),
      customerReviews: List<RestaurantCustomerReview>.from(
        json['customerReviews'].map(
          (x) => RestaurantCustomerReview.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'city': city,
        'address': address,
        'pictureId': pictureId,
        'categories': List<dynamic>.from(
          categories.map((x) => x.toJson()),
        ),
        'menus': menus.toJson(),
        'rating': rating,
        'customerReviews': List<dynamic>.from(
          customerReviews.map((x) => x.toJson()),
        ),
      };
}
