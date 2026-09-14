import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/book_repository.dart';

class DeleteBook {
  const DeleteBook(this.repository);

  final BookRepository repository;

  Future<Either<Failure, bool>> call(int bookId) {
    return repository.deleteBook(bookId);
  }
}