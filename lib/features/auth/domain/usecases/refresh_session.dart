import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class RefreshSession {
  const RefreshSession(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthSession>> call(
      String refreshToken,
      ) {
    return repository.refresh(refreshToken);
  }
}