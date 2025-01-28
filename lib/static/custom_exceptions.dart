class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class BadRequestException extends AppException {
  const BadRequestException([super.message = 'Request is invalid.']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Request is unauthorized.']);
}

class ForbiddenException extends AppException {
  const ForbiddenException([super.message = 'Request is forbidden.']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Not found.']);
}

class ServerException extends AppException {
  const ServerException([super.message = 'Server error.']);
}
