import 'package:fpdart/fpdart.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/borrowing.dart';
import '../../domain/repositories/borrowing_repository.dart';
import '../datasources/borrowing_remote_data_source.dart';

class BorrowingRepositoryImpl implements BorrowingRepository {
  BorrowingRepositoryImpl(this.dataSource);

  final BorrowingRemoteDataSource dataSource;

  @override
  Future<Either<Failure, List<Borrowing>>> getBorrowings() async {
    try {
      final borrowings = await dataSource.getBorrowings();

      return Right(borrowings);
    } on ApiException catch (error) {
      return Left(BorrowingFailure(error.message));
    } catch (_) {
      return const Left(BorrowingFailure('Could not load borrowings.'));
    }
  }

  @override
  Future<Either<Failure, List<Borrowing>>> getMemberBorrowings(
    int memberId,
  ) async {
    try {
      final borrowings = await dataSource.getMemberBorrowings(memberId);

      return Right(borrowings);
    } on ApiException catch (error) {
      return Left(BorrowingFailure(error.message));
    } catch (_) {
      return const Left(BorrowingFailure('Could not load your borrowings.'));
    }
  }

  @override
  Future<Either<Failure, Borrowing>> borrowBook({
    required int memberId,
    required int bookId,
  }) async {
    try {
      final borrowing = await dataSource.borrowBook(
        memberId: memberId,
        bookId: bookId,
      );

      return Right(borrowing);
    } on ApiException catch (error) {
      return Left(BorrowingFailure(error.message));
    } catch (_) {
      return const Left(BorrowingFailure('Could not borrow this book.'));
    }
  }

  @override
  Future<Either<Failure, Borrowing>> returnBook(int borrowingId) async {
    try {
      final borrowing = await dataSource.returnBook(borrowingId);
      return Right(borrowing);
    } on ApiException catch (error) {
      return Left(BorrowingFailure(error.message));
    } catch (_) {
      return const Left(BorrowingFailure('Could not return this book.'));
    }
  }
}
