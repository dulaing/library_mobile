import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/book_cover_remote_data_source.dart';
import '../../data/datasources/book_remote_data_source.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecases/create_book.dart';
import '../../domain/usecases/delete_book.dart';
import '../../domain/usecases/get_book.dart';
import '../../domain/usecases/get_books.dart';
import '../../domain/usecases/update_book.dart';

part 'book_providers.g.dart';

Duration? noRetry(int retryCount, Object error) {
  return null;
}

@riverpod
BookRemoteDataSource bookRemoteDataSource(Ref ref) {
  final dio = ref.watch(apiClientProvider);

  return BookRemoteDataSourceImpl(dio);
}

@Riverpod(keepAlive: true)
BookCoverRemoteDataSource bookCoverRemoteDataSource(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://openlibrary.org',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  return BookCoverRemoteDataSource(dio);
}

// Kept alive so each title is only looked up once per session.
@Riverpod(keepAlive: true, retry: noRetry)
Future<int?> bookCoverId(Ref ref, String title, String? author) {
  final dataSource = ref.watch(bookCoverRemoteDataSourceProvider);

  return dataSource.findCoverId(title: title, author: author);
}

@riverpod
BookRepository bookRepository(Ref ref) {
  final dataSource = ref.watch(bookRemoteDataSourceProvider);

  return BookRepositoryImpl(dataSource);
}

@riverpod
GetBooks getBooks(Ref ref) {
  final repository = ref.watch(bookRepositoryProvider);

  return GetBooks(repository);
}

@riverpod
GetBook getBook(Ref ref) {
  return GetBook(
    ref.watch(bookRepositoryProvider),
  );
}

@riverpod
CreateBook createBook(Ref ref) {
  return CreateBook(ref.watch(bookRepositoryProvider));
}

@riverpod
UpdateBook updateBook(Ref ref) {
  return UpdateBook(ref.watch(bookRepositoryProvider));
}

@riverpod
DeleteBook deleteBook(Ref ref) {
  return DeleteBook(ref.watch(bookRepositoryProvider));
}

@Riverpod(retry: noRetry)
Future<List<Book>> books(Ref ref) async {
  final getBooks = ref.watch(getBooksProvider);
  final result = await getBooks();

  return result.fold(
        (failure) => throw failure,
        (books) => books,
  );
}

@Riverpod(retry: noRetry)
Future<Book> book(Ref ref, int bookId) async {
  final getBook = ref.watch(getBookProvider);
  final result = await getBook(bookId);

  return result.fold(
        (failure) => throw failure,
        (book) => book,
  );
}

@riverpod
class AdminBookController extends _$AdminBookController {
  @override
  FutureOr<void> build() {}

  Future<Book?> create({
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  }) async {
    state = const AsyncLoading();

    final result = await ref.read(createBookProvider)(
      title: title,
      author: author,
      isbn: isbn,
      publishedYear: publishedYear,
      totalCopies: totalCopies,
    );

    return result.fold(
          (failure) {
        state = AsyncError(failure, StackTrace.current);
        return null;
      },
          (book) {
        ref.invalidate(booksProvider);
        state = const AsyncData(null);
        return book;
      },
    );
  }

  Future<Book?> updateBook({
    required int bookId,
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  }) async {
    state = const AsyncLoading();

    final result = await ref.read(updateBookProvider)(
      bookId: bookId,
      title: title,
      author: author,
      isbn: isbn,
      publishedYear: publishedYear,
      totalCopies: totalCopies,
    );

    return result.fold(
          (failure) {
        state = AsyncError(failure, StackTrace.current);
        return null;
      },
          (book) {
        ref.invalidate(booksProvider);
        ref.invalidate(bookProvider(bookId));
        state = const AsyncData(null);
        return book;
      },
    );
  }

  Future<bool> delete(int bookId) async {
    state = const AsyncLoading();

    final result = await ref.read(deleteBookProvider)(bookId);

    return result.fold(
          (failure) {
        state = AsyncError(failure, StackTrace.current);
        return false;
      },
          (deleted) {
        ref.invalidate(booksProvider);
        ref.invalidate(bookProvider(bookId));
        state = const AsyncData(null);
        return deleted;
      },
    );
  }
}