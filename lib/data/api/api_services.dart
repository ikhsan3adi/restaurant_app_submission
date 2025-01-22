import 'package:restaurant_app/data/enums/image_size.dart';

class ApiServices {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  static String restaurantImageUrl(String pictureId, ImageSize size) {
    return '$_baseUrl/images/${size.name}/$pictureId';
  }
}
