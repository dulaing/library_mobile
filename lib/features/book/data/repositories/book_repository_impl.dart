import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_local_datasource.dart';

class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl(this.dataSource);

  final BookLocalDataSource dataSource;

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      final books = await dataSource.getBooks();
      return Right(books);
    } catch (_) {
      return const Left(DataFailure());
    }
  }
}