import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/borrowing.dart';
import '../repositories/borrowing_repository.dart';

class ReturnBook {
  const ReturnBook(this.repository);

  final BorrowingRepository repository;

  Future<Either<Failure, Borrowing>> call(int borrowingId) {
    return repository.returnBook(borrowingId);
  }
}
