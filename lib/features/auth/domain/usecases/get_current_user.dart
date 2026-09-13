import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/current_user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser {
  const GetCurrentUser(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, CurrentUser>> call() {
    return repository.getCurrentUser();
  }
}