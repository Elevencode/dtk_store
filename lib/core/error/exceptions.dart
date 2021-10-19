class ServerException implements Exception {
  dynamic exception;

  ServerException({this.exception});

  @override
  String toString() => exception?.toString() ?? super.toString();
}
