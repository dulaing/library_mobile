import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../models/member_model.dart';

abstract class MemberRemoteDataSource {
  Future<MemberModel> getMember(int memberId);

  Future<MemberModel> updateMember({
    required int memberId,
    required String fullName,
    required String email,
    required String? phoneNumber,
    required bool isActive,
  });
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  MemberRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<MemberModel> getMember(int memberId) async {
    try {
      final response = await dio.get('/api/members/$memberId');
      return memberFromResponse(response.data);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @override
  Future<MemberModel> updateMember({
    required int memberId,
    required String fullName,
    required String email,
    required String? phoneNumber,
    required bool isActive,
  }) async {
    try {
      final response = await dio.put(
        '/api/members/$memberId',
        data: {
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber,
          'isActive': isActive,
        },
      );

      return memberFromResponse(response.data);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  MemberModel memberFromResponse(dynamic responseData) {
    if (responseData is! Map) {
      throw const ApiException('The server returned invalid member data.');
    }

    return MemberModel.fromJson(Map<String, dynamic>.from(responseData));
  }
}
