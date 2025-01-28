import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/enum/image_size.dart';
import 'package:restaurant_app/data/model/new_restaurant_review.dart';
import 'package:restaurant_app/data/model/new_restaurant_review_response.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restaurant_search_response.dart';
import 'package:restaurant_app/static/custom_exceptions.dart';

class ApiServices {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  static String restaurantImageUrl(String pictureId, ImageSize size) {
    return '$_baseUrl/images/${size.name}/$pictureId';
  }

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));

    if (response.statusCode == 400) {
      throw BadRequestException();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 403) {
      throw ForbiddenException();
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else if (response.statusCode != 200) {
      throw AppException('Failed to load restaurant list.');
    }

    return RestaurantListResponse.fromJson(jsonDecode(response.body));
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

    if (response.statusCode == 400) {
      throw BadRequestException();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 403) {
      throw ForbiddenException();
    } else if (response.statusCode == 404) {
      throw NotFoundException('Restaurant not found.');
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else if (response.statusCode != 200) {
      throw AppException('Failed to load restaurant detail.');
    }

    return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
  }

  Future<RestaurantSearchResponse> getRestaurantSearchResult(
    String query,
  ) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

    if (response.statusCode == 400) {
      throw BadRequestException();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 403) {
      throw ForbiddenException();
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else if (response.statusCode != 200) {
      throw AppException('Failed to search restaurant.');
    }

    return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
  }

  Future<NewRestaurantReviewResponse> postRestaurantReview(
    NewRestaurantReview review,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      body: jsonEncode(review.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 400) {
      throw BadRequestException();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 403) {
      throw ForbiddenException();
    } else if (response.statusCode == 500) {
      throw ServerException();
    } else if (response.statusCode != 201) {
      throw AppException('Failed to add review.');
    }

    return NewRestaurantReviewResponse.fromJson(jsonDecode(response.body));
  }
}
