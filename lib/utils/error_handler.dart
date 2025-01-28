import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:restaurant_app/static/custom_exceptions.dart';

class ErrorHandler {
  static String handleError(error) {
    if (error is SocketException) {
      return 'Unable to connect to the server. Please check your internet connection.';
    } else if (error is TimeoutException) {
      return 'The request timed out. Please try again.';
    } else if (error is HttpException) {
      return 'An error occurred while processing your request. Please try again later.';
    } else if (error is FormatException) {
      return 'Invalid data format. Please try again later.';
    } else if (error is ClientException) {
      return 'An error occurred while processing your request. Please try again later.';
    } else if (error is AppException) {
      return error.message;
    } else if (error is Exception) {
      return 'An unexpected error occurred. Please try again.';
    } else {
      return 'Something went wrong. Please try again.';
    }
  }
}
