import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/book.dart';
import '../repositories/book_repository.dart';

class GetBooks {
  GetBooks(this.repository);

  final BookRepository repository;

  Future<Either<Failure, List<Book>>> call() {
    return repository.getBooks();
  }
}