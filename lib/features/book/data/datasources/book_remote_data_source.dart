import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getBooks();

  Future<BookModel> getBook(int bookId);

  Future<BookModel> createBook({
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  });

  Future<BookModel> updateBook({
    required int bookId,
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  });

  Future<void> deleteBook(int bookId);
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

      return _readBook(response.data);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @override
  Future<BookModel> createBook({
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  }) async {
    try {
      final response = await dio.post(
        '/api/books',
        data: {
          'title': title,
          'author': author,
          'isbn': isbn,
          'publishedYear': publishedYear,
          'totalCopies': totalCopies,
        },
      );

      return _readBook(response.data);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @override
  Future<BookModel> updateBook({
    required int bookId,
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  }) async {
    try {
      final response = await dio.put(
        '/api/books/$bookId',
        data: {
          'title': title,
          'author': author,
          'isbn': isbn,
          'publishedYear': publishedYear,
          'totalCopies': totalCopies,
        },
      );

      return _readBook(response.data);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @override
  Future<void> deleteBook(int bookId) async {
    try {
      await dio.delete('/api/books/$bookId');
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  BookModel _readBook(dynamic data) {
    if (data is! Map) {
      throw const ApiException(
        'The server returned invalid book data.',
      );
    }

    return BookModel.fromJson(
      Map<String, dynamic>.from(data),
    );
  }
}