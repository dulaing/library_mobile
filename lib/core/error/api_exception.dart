import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  factory ApiException.fromDio(DioException error) {
    final responseData = error.response?.data;

    if (responseData is Map<String, dynamic>) {
      final detail = responseData['detail'];

      if (detail is String && detail.isNotEmpty) {
        return ApiException(detail);
      }
    }

    if (error.response == null) {
      return const ApiException(
        'Could not connect to the library server.',
      );
    }

    return const ApiException(
      'The server could not complete the request.',
    );
  }
}