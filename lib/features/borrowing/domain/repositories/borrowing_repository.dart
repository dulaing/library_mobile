import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/borrowing.dart';

abstract class BorrowingRepository {
  Future<Either<Failure, List<Borrowing>>> getMemberBorrowings(
      int memberId,
      );
}