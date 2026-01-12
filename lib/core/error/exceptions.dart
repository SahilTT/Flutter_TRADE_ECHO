class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server Error']);
}

class CacheException implements Exception {}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException([this.message = 'Authentication Error']);
}
