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

  Future<List<MemberModel>> getMembers();

  Future<MemberModel> createMemberAccount({
    required String fullName,
    required String email,
    required String? phoneNumber,
    required String password,
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

  @override
  Future<List<MemberModel>> getMembers() async {
    try {
      final response = await dio.get('/api/members');
      final responseData = response.data;

      if (responseData is! List) {
        throw const ApiException(
          'The server returned an invalid member list.',
        );
      }

      return responseData.map((item) {
        if (item is! Map) {
          throw const ApiException(
            'The server returned invalid member data.',
          );
        }

        return MemberModel.fromJson(
          Map<String, dynamic>.from(item),
        );
      }).toList();
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @override
  Future<MemberModel> createMemberAccount({
    required String fullName,
    required String email,
    required String? phoneNumber,
    required String password,
  }) async {
    try {
      final memberResponse = await dio.post(
        '/api/members',
        data: {
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber,
        },
      );

      final member = memberFromResponse(memberResponse.data);

      await dio.post(
        '/api/users',
        data: {
          'email': email,
          'password': password,
          'role': 'Member',
          'memberId': member.id,
        },
      );

      return member;
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
