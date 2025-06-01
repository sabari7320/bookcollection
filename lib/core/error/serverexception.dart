class ServerException implements Exception {
  final String? message;
  ServerException([this.message = "Something error occured"]);
}
