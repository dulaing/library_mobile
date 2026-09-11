import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../models/borrowing_model.dart';

abstract class BorrowingRemoteDataSource {
  Future<List<BorrowingModel>> getMemberBorrowings(int memberId);

  Future<BorrowingModel> borrowBook({
    required int memberId,
    required int bookId,
  });
}

class BorrowingRemoteDataSourceImpl implements BorrowingRemoteDataSource {
  BorrowingRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<BorrowingModel>> getMemberBorrowings(int memberId) async {
    try {
      final response = await dio.get('/api/members/$memberId/borrowings');

      final responseData = response.data;

      if (responseData is! List) {
        throw const ApiException('The server returned invalid borrowing data.');
      }

      return responseData.map((item) {
        final json = Map<String, dynamic>.from(item as Map);

        return BorrowingModel.fromJson(json);
      }).toList();
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @override
  Future<BorrowingModel> borrowBook({
    required int memberId,
    required int bookId,
  }) async {
    try {
      final response = await dio.post(
        '/api/borrowings',
        data: {'memberId': memberId, 'bookId': bookId},
      );

      final responseData = response.data;

      if (responseData is! Map) {
        throw const ApiException('The server returned invalid borrowing data.');
      }

      return BorrowingModel.fromJson(Map<String, dynamic>.from(responseData));
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }
}
