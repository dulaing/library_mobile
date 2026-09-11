import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/borrowing.dart';
import '../repositories/borrowing_repository.dart';

class BorrowBook {
  const BorrowBook(this.repository);

  final BorrowingRepository repository;

  Future<Either<Failure, Borrowing>> call({
    required int memberId,
    required int bookId,
  }) {
    return repository.borrowBook(memberId: memberId, bookId: bookId);
  }
}
