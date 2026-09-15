import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/borrowing.dart';
import '../repositories/borrowing_repository.dart';

class GetBorrowings {
  const GetBorrowings(this.repository);

  final BorrowingRepository repository;

  Future<Either<Failure, List<Borrowing>>> call() {
    return repository.getBorrowings();
  }
}
