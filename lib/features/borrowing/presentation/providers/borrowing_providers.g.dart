// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrowing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(borrowingRemoteDataSource)
final borrowingRemoteDataSourceProvider = BorrowingRemoteDataSourceProvider._();

final class BorrowingRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          BorrowingRemoteDataSource,
          BorrowingRemoteDataSource,
          BorrowingRemoteDataSource
        >
    with $Provider<BorrowingRemoteDataSource> {
  BorrowingRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'borrowingRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$borrowingRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<BorrowingRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BorrowingRemoteDataSource create(Ref ref) {
    return borrowingRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BorrowingRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BorrowingRemoteDataSource>(value),
    );
  }
}

String _$borrowingRemoteDataSourceHash() =>
    r'489ab00d1e6fba5e5692177882ffec3a561f688c';

@ProviderFor(borrowingRepository)
final borrowingRepositoryProvider = BorrowingRepositoryProvider._();

final class BorrowingRepositoryProvider
    extends
        $FunctionalProvider<
          BorrowingRepository,
          BorrowingRepository,
          BorrowingRepository
        >
    with $Provider<BorrowingRepository> {
  BorrowingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'borrowingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$borrowingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BorrowingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BorrowingRepository create(Ref ref) {
    return borrowingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BorrowingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BorrowingRepository>(value),
    );
  }
}

String _$borrowingRepositoryHash() =>
    r'28abab0b4f54de1d962e9531ef39b010fec87885';

@ProviderFor(getMemberBorrowings)
final getMemberBorrowingsProvider = GetMemberBorrowingsProvider._();

final class GetMemberBorrowingsProvider
    extends
        $FunctionalProvider<
          GetMemberBorrowings,
          GetMemberBorrowings,
          GetMemberBorrowings
        >
    with $Provider<GetMemberBorrowings> {
  GetMemberBorrowingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMemberBorrowingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMemberBorrowingsHash();

  @$internal
  @override
  $ProviderElement<GetMemberBorrowings> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetMemberBorrowings create(Ref ref) {
    return getMemberBorrowings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMemberBorrowings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMemberBorrowings>(value),
    );
  }
}

String _$getMemberBorrowingsHash() =>
    r'a53fc75f38b3b0c15106651a0bfc45f081c51086';

@ProviderFor(getBorrowings)
final getBorrowingsProvider = GetBorrowingsProvider._();

final class GetBorrowingsProvider
    extends $FunctionalProvider<GetBorrowings, GetBorrowings, GetBorrowings>
    with $Provider<GetBorrowings> {
  GetBorrowingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBorrowingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBorrowingsHash();

  @$internal
  @override
  $ProviderElement<GetBorrowings> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetBorrowings create(Ref ref) {
    return getBorrowings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBorrowings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBorrowings>(value),
    );
  }
}

String _$getBorrowingsHash() => r'88fbab5227fc839419c78508959fabd4fc04cde2';

@ProviderFor(borrowBook)
final borrowBookProvider = BorrowBookProvider._();

final class BorrowBookProvider
    extends $FunctionalProvider<BorrowBook, BorrowBook, BorrowBook>
    with $Provider<BorrowBook> {
  BorrowBookProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'borrowBookProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$borrowBookHash();

  @$internal
  @override
  $ProviderElement<BorrowBook> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BorrowBook create(Ref ref) {
    return borrowBook(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BorrowBook value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BorrowBook>(value),
    );
  }
}

String _$borrowBookHash() => r'c92308b05693bb2dc1bd6d844834f3a363c8a4ea';

@ProviderFor(BorrowBookController)
final borrowBookControllerProvider = BorrowBookControllerFamily._();

final class BorrowBookControllerProvider
    extends $AsyncNotifierProvider<BorrowBookController, void> {
  BorrowBookControllerProvider._({
    required BorrowBookControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'borrowBookControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$borrowBookControllerHash();

  @override
  String toString() {
    return r'borrowBookControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BorrowBookController create() => BorrowBookController();

  @override
  bool operator ==(Object other) {
    return other is BorrowBookControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$borrowBookControllerHash() =>
    r'2e700b58f03de9a88052b143812cfd151e2ce912';

final class BorrowBookControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BorrowBookController,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  BorrowBookControllerFamily._()
    : super(
        retry: null,
        name: r'borrowBookControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BorrowBookControllerProvider call(int bookId) =>
      BorrowBookControllerProvider._(argument: bookId, from: this);

  @override
  String toString() => r'borrowBookControllerProvider';
}

abstract class _$BorrowBookController extends $AsyncNotifier<void> {
  late final _$args = ref.$arg as int;
  int get bookId => _$args;

  FutureOr<void> build(int bookId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(returnBook)
final returnBookProvider = ReturnBookProvider._();

final class ReturnBookProvider
    extends $FunctionalProvider<ReturnBook, ReturnBook, ReturnBook>
    with $Provider<ReturnBook> {
  ReturnBookProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'returnBookProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$returnBookHash();

  @$internal
  @override
  $ProviderElement<ReturnBook> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReturnBook create(Ref ref) {
    return returnBook(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReturnBook value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReturnBook>(value),
    );
  }
}

String _$returnBookHash() => r'340980104280cae066280370d55a25cdd570e0ed';

@ProviderFor(ReturnBookController)
final returnBookControllerProvider = ReturnBookControllerFamily._();

final class ReturnBookControllerProvider
    extends $AsyncNotifierProvider<ReturnBookController, void> {
  ReturnBookControllerProvider._({
    required ReturnBookControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'returnBookControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$returnBookControllerHash();

  @override
  String toString() {
    return r'returnBookControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ReturnBookController create() => ReturnBookController();

  @override
  bool operator ==(Object other) {
    return other is ReturnBookControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$returnBookControllerHash() =>
    r'a3b2abfdea859b26f5f9183da81d68dcdfa32782';

final class ReturnBookControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ReturnBookController,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  ReturnBookControllerFamily._()
    : super(
        retry: null,
        name: r'returnBookControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReturnBookControllerProvider call(int borrowingId) =>
      ReturnBookControllerProvider._(argument: borrowingId, from: this);

  @override
  String toString() => r'returnBookControllerProvider';
}

abstract class _$ReturnBookController extends $AsyncNotifier<void> {
  late final _$args = ref.$arg as int;
  int get borrowingId => _$args;

  FutureOr<void> build(int borrowingId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(allBorrowings)
final allBorrowingsProvider = AllBorrowingsProvider._();

final class AllBorrowingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Borrowing>>,
          List<Borrowing>,
          FutureOr<List<Borrowing>>
        >
    with $FutureModifier<List<Borrowing>>, $FutureProvider<List<Borrowing>> {
  AllBorrowingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noBorrowingRetry,
        name: r'allBorrowingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allBorrowingsHash();

  @$internal
  @override
  $FutureProviderElement<List<Borrowing>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Borrowing>> create(Ref ref) {
    return allBorrowings(ref);
  }
}

String _$allBorrowingsHash() => r'9078dfdcade2bdd3e3ead1ff990f601a7e62ce09';

@ProviderFor(memberBorrowings)
final memberBorrowingsProvider = MemberBorrowingsFamily._();

final class MemberBorrowingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Borrowing>>,
          List<Borrowing>,
          FutureOr<List<Borrowing>>
        >
    with $FutureModifier<List<Borrowing>>, $FutureProvider<List<Borrowing>> {
  MemberBorrowingsProvider._({
    required MemberBorrowingsFamily super.from,
    required int super.argument,
  }) : super(
         retry: noBorrowingRetry,
         name: r'memberBorrowingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberBorrowingsHash();

  @override
  String toString() {
    return r'memberBorrowingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Borrowing>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Borrowing>> create(Ref ref) {
    final argument = this.argument as int;
    return memberBorrowings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MemberBorrowingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberBorrowingsHash() => r'51386c1181eb79441a742b66dfffccc974f84e4e';

final class MemberBorrowingsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Borrowing>>, int> {
  MemberBorrowingsFamily._()
    : super(
        retry: noBorrowingRetry,
        name: r'memberBorrowingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberBorrowingsProvider call(int memberId) =>
      MemberBorrowingsProvider._(argument: memberId, from: this);

  @override
  String toString() => r'memberBorrowingsProvider';
}
