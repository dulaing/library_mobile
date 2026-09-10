import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

class ApiClient {
  static Dio create() {
    const baseUrl = String.fromEnvironment(
      'API_BASE_URL',
      // Inside the emulator, localhost means the emulator itself. Android provides this special address for reaching your computer:
      defaultValue: 'http://10.0.2.2:5131',
    );

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}

// making Dio available through Riverpod
@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  return ApiClient.create();
}