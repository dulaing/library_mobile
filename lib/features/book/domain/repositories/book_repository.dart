import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/book.dart';

abstract class BookRepository {
  Future<Either<Failure, List<Book>>> getBooks();

  Future<Either<Failure, Book>> getBook(int bookId);

  Future<Either<Failure, Book>> createBook({
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  });

  Future<Either<Failure, Book>> updateBook({
    required int bookId,
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  });

  Future<Either<Failure, bool>> deleteBook(int bookId);
}