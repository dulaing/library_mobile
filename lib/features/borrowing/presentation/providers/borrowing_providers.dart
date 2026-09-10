import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/borrowing_remote_data_source.dart';
import '../../data/repositories/borrowing_repository_impl.dart';
import '../../domain/entities/borrowing.dart';
import '../../domain/repositories/borrowing_repository.dart';
import '../../domain/usecases/get_member_borrowings.dart';

part 'borrowing_providers.g.dart';

@riverpod
BorrowingRemoteDataSource borrowingRemoteDataSource(Ref ref) {
  final dio = ref.watch(apiClientProvider);

  return BorrowingRemoteDataSourceImpl(dio);
}

@riverpod
BorrowingRepository borrowingRepository(Ref ref) {
  final dataSource = ref.watch(
    borrowingRemoteDataSourceProvider,
  );

  return BorrowingRepositoryImpl(dataSource);
}

@riverpod
GetMemberBorrowings getMemberBorrowings(Ref ref) {
  final repository = ref.watch(
    borrowingRepositoryProvider,
  );

  return GetMemberBorrowings(repository);
}

@Riverpod(retry: noBorrowingRetry)
Future<List<Borrowing>> memberBorrowings(
    Ref ref,
    int memberId,
    ) async {
  final getBorrowings = ref.watch(
    getMemberBorrowingsProvider,
  );

  // actually using
  final result = await getBorrowings(memberId);

  return result.fold(
        (failure) => throw failure,
        (borrowings) => borrowings,
  );
}

// prevents Riverpod from repeatedly calling a failed endpoint. The screen will have a Retry button instead
Duration? noBorrowingRetry(
    int retryCount,
    Object error,
    ) {
  return null;
}