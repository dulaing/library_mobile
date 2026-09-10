import 'package:fpdart/fpdart.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.dataSource);

  final AuthRemoteDataSource dataSource;

  @override
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await dataSource.login(
        email: email,
        password: password,
      );

      return Right(session);
    } on ApiException catch (error) {
      return Left(
        AuthFailure(error.message),
      );
    } catch (_) {
      return const Left(
        AuthFailure('Could not sign in.'),
      );
    }
  }
}