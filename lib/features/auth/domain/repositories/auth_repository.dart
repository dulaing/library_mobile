import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_session.dart';
import '../entities/current_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout(String refreshToken);

  Future<Either<Failure, AuthSession>> refresh(String refreshToken);

  Future<Either<Failure, CurrentUser>> getCurrentUser();
}
