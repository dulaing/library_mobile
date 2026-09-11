import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class Logout {
  const Logout(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, void>> call(String refreshToken) {
    return repository.logout(refreshToken);
  }
}
