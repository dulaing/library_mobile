import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../models/auth_session_model.dart';
import '../models/current_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });

  Future<void> logout(String refreshToken);

  Future<AuthSessionModel> refresh(String refreshToken);

  Future<CurrentUserModel> getCurrentUser();
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

  @override
  Future<AuthSessionModel> refresh(String refreshToken) async {
    try {
      final response = await dio.post(
        '/api/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final responseData = response.data;

      if (responseData is! Map) {
        throw const ApiException(
          'The server returned invalid session data.',
        );
      }

      return AuthSessionModel.fromJson(
        Map<String, dynamic>.from(responseData),
      );
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @override
  Future<CurrentUserModel> getCurrentUser() async {
    try {
      final response = await dio.get('/api/auth/me');
      final responseData = response.data;

      if (responseData is! Map) {
        throw const ApiException(
          'The server returned invalid user data.',
        );
      }

      return CurrentUserModel.fromJson(
        Map<String, dynamic>.from(responseData),
      );
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }
}
