import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/book.dart';
import '../repositories/book_repository.dart';

class GetBook {
  const GetBook(this.repository);

  final BookRepository repository;

  Future<Either<Failure, Book>> call(int bookId) {
    return repository.getBook(bookId);
  }
}