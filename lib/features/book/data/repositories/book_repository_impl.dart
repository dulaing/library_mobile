import 'package:fpdart/fpdart.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_data_source.dart';

class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl(this.dataSource);

  final BookRemoteDataSource dataSource;

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      final books = await dataSource.getBooks();

      return Right(books);
    } on ApiException catch (error) {
      return Left(DataFailure(error.message));
    } catch (_) {
      return const Left(DataFailure());
    }
  }

  @override
  Future<Either<Failure, Book>> getBook(int bookId) async {
    try {
      final book = await dataSource.getBook(bookId);

      return Right(book);
    } on ApiException catch (error) {
      return Left(DataFailure(error.message));
    } catch (_) {
      return const Left(DataFailure('Could not load this book.'));
    }
  }

  @override
  Future<Either<Failure, Book>> createBook({
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  }) async {
    try {
      final book = await dataSource.createBook(
        title: title,
        author: author,
        isbn: isbn,
        publishedYear: publishedYear,
        totalCopies: totalCopies,
      );

      return Right(book);
    } on ApiException catch (error) {
      return Left(DataFailure(error.message));
    } catch (_) {
      return const Left(DataFailure('Could not create the book.'));
    }
  }

  @override
  Future<Either<Failure, Book>> updateBook({
    required int bookId,
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  }) async {
    try {
      final book = await dataSource.updateBook(
        bookId: bookId,
        title: title,
        author: author,
        isbn: isbn,
        publishedYear: publishedYear,
        totalCopies: totalCopies,
      );

      return Right(book);
    } on ApiException catch (error) {
      return Left(DataFailure(error.message));
    } catch (_) {
      return const Left(DataFailure('Could not update the book.'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBook(int bookId) async {
    try {
      await dataSource.deleteBook(bookId);

      return const Right(true);
    } on ApiException catch (error) {
      return Left(DataFailure(error.message));
    } catch (_) {
      return const Left(DataFailure('Could not delete the book.'));
    }
  }
}