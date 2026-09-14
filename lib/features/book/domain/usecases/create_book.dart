import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/book.dart';
import '../repositories/book_repository.dart';

class CreateBook {
  const CreateBook(this.repository);

  final BookRepository repository;

  Future<Either<Failure, Book>> call({
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  }) {
    return repository.createBook(
      title: title,
      author: author,
      isbn: isbn,
      publishedYear: publishedYear,
      totalCopies: totalCopies,
    );
  }
}