import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../models/auth_session_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });

  Future<void> logout(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/api/auth/login',
        data: {'email': email, 'password': password},
      );

      final responseData = response.data;

      if (responseData is! Map) {
        throw const ApiException('The server returned invalid login data.');
      }

      final json = Map<String, dynamic>.from(responseData);

      return AuthSessionModel.fromJson(json);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @override
  Future<void> logout(String refreshToken) async {
    try {
      await dio.post('/api/auth/logout', data: {'refreshToken': refreshToken});
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }
}
