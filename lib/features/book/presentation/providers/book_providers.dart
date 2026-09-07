import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/book_local_datasource.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecases/get_books.dart';

part 'book_providers.g.dart';

Duration? noRetry(int retryCount, Object error) {
  return null;
}

@riverpod
BookLocalDataSource bookLocalDataSource(Ref ref) {
  return BookLocalDataSourceImpl();
}

@riverpod
BookRepository bookRepository(Ref ref) {
  final dataSource = ref.watch(bookLocalDataSourceProvider);
  return BookRepositoryImpl(dataSource);
}

@riverpod
GetBooks getBooks(Ref ref) {
  final repository = ref.watch(bookRepositoryProvider);
  return GetBooks(repository);
}

@Riverpod(retry: noRetry)
Future<List<Book>> books(Ref ref) async {
  final getBooks = ref.watch(getBooksProvider);
  final result = await getBooks();

  return result.fold((failure) => throw failure, (books) => books);
}
