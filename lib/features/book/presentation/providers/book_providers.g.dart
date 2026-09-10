// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookRemoteDataSource)
final bookRemoteDataSourceProvider = BookRemoteDataSourceProvider._();

final class BookRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          BookRemoteDataSource,
          BookRemoteDataSource,
          BookRemoteDataSource
        >
    with $Provider<BookRemoteDataSource> {
  BookRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<BookRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookRemoteDataSource create(Ref ref) {
    return bookRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookRemoteDataSource>(value),
    );
  }
}

String _$bookRemoteDataSourceHash() =>
    r'e989140d74d19feac50544d9fc1a2a2d68a44c48';

@ProviderFor(bookRepository)
final bookRepositoryProvider = BookRepositoryProvider._();

final class BookRepositoryProvider
    extends $FunctionalProvider<BookRepository, BookRepository, BookRepository>
    with $Provider<BookRepository> {
  BookRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BookRepository create(Ref ref) {
    return bookRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookRepository>(value),
    );
  }
}

String _$bookRepositoryHash() => r'e1f7f6aa08227d64c74ac591647f98eb2f92a5c8';

@ProviderFor(getBooks)
final getBooksProvider = GetBooksProvider._();

final class GetBooksProvider
    extends $FunctionalProvider<GetBooks, GetBooks, GetBooks>
    with $Provider<GetBooks> {
  GetBooksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBooksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBooksHash();

  @$internal
  @override
  $ProviderElement<GetBooks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetBooks create(Ref ref) {
    return getBooks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBooks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBooks>(value),
    );
  }
}

String _$getBooksHash() => r'1867d33baeb491e943ac27ce3842aa02901a6fde';

@ProviderFor(books)
final booksProvider = BooksProvider._();

final class BooksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Book>>,
          List<Book>,
          FutureOr<List<Book>>
        >
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  BooksProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'booksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$booksHash();

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    return books(ref);
  }
}

String _$booksHash() => r'870829081f77da5569a3b1c4cb1e3820a074509f';
