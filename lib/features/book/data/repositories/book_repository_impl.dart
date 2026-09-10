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
    } on ApiException {
      return const Left(DataFailure());
    }
  }
}