import 'package:fpdart/fpdart.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/current_user.dart';
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
      final session = await dataSource.login(email: email, password: password);

      return Right(session);
    } on ApiException catch (error) {
      return Left(AuthFailure(error.message));
    } catch (_) {
      return const Left(AuthFailure('Could not sign in.'));
    }
  }

  @override
  Future<Either<Failure, void>> logout(String refreshToken) async {
    try {
      await dataSource.logout(refreshToken);
      return const Right(null);
    } on ApiException catch (error) {
      return Left(AuthFailure(error.message));
    } catch (_) {
      return const Left(AuthFailure('Could not sign out.'));
    }
  }

  @override
  Future<Either<Failure, AuthSession>> refresh(
      String refreshToken,
      ) async {
    try {
      final session = await dataSource.refresh(refreshToken);
      return Right(session);
    } on ApiException catch (error) {
      return Left(AuthFailure(error.message));
    } catch (_) {
      return const Left(
        AuthFailure('Could not refresh the session.'),
      );
    }
  }

  @override
  Future<Either<Failure, CurrentUser>> getCurrentUser() async {
    try {
      final user = await dataSource.getCurrentUser();
      return Right(user);
    } on ApiException catch (error) {
      return Left(AuthFailure(error.message));
    } catch (_) {
      return const Left(
        AuthFailure('Could not verify the session.'),
      );
    }
  }
}
