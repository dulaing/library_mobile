import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getBooks();
  Future<BookModel> getBook(int bookId);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  BookRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<BookModel>> getBooks() async {
    try {
      final response = await dio.get('/api/books');
      final data = response.data;

      if (data is! List) {
        throw const ApiException(
          'The server returned an invalid book list.',
        );
      }

      return data.map((item) {
        if (item is! Map<String, dynamic>) {
          throw const ApiException(
            'The server returned an invalid book.',
          );
        }

        return BookModel.fromJson(item);
      }).toList();
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @override
  Future<BookModel> getBook(int bookId) async {
    try {
      final response = await dio.get('/api/books/$bookId');
      final data = response.data;

      if (data is! Map) {
        throw const ApiException(
          'The server returned invalid book data.',
        );
      }

      return BookModel.fromJson(
        Map<String, dynamic>.from(data),
      );
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }
}