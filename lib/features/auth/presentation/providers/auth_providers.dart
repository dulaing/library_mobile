import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/refresh_session.dart';
import '../../domain/usecases/restore_session.dart';
import '../../domain/entities/auth_session.dart';


part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final dio = ref.watch(apiClientProvider);

  return AuthRemoteDataSourceImpl(dio);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(authLocalDataSourceProvider),
  );
}

@riverpod
Login login(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);

  return Login(repository);
}

@riverpod
Logout logout(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);

  return Logout(repository);
}

@riverpod
RefreshSession refreshSession(Ref ref) {
  return RefreshSession(ref.watch(authRepositoryProvider));
}

@riverpod
GetCurrentUser getCurrentUser(Ref ref) {
  return GetCurrentUser(ref.watch(authRepositoryProvider));
}

@riverpod
RestoreSession restoreSession(Ref ref) {
  return RestoreSession(
    ref.watch(authRepositoryProvider),
  );
}

// local data-source provider:
@Riverpod(keepAlive: true)
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSourceImpl(
    const FlutterSecureStorage(),
  );
}

// controller that performs login and remembers its current state.
// keepAlive: true means Riverpod keeps the logged-in session in memory while the app is running.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AuthSession?> build() async {
    final savedSession = await ref.read(restoreSessionProvider)();

    if (savedSession == null) {
      return null;
    }

    if (savedSession.refreshTokenIsExpired) {
      await ref.read(logoutProvider)(savedSession.refreshToken);
      return null;
    }

    var activeSession = savedSession;

    if (savedSession.accessTokenIsExpired) {
      final result = await ref.read(
        refreshSessionProvider,
      )(savedSession.refreshToken);

      final refreshedSession = result.fold<AuthSession?>(
            (failure) => null,
            (session) => session,
      );

      if (refreshedSession == null) {
        await ref.read(logoutProvider)(savedSession.refreshToken);
        return null;
      }

      activeSession = refreshedSession;
    }

    final dio = ref.read(apiClientProvider);

    dio.options.headers['Authorization'] =
    'Bearer ${activeSession.accessToken}';

    final currentUserResult = await ref.read(
      getCurrentUserProvider,
    )();

    final currentUser = currentUserResult.fold(
          (failure) => null,
          (user) => user,
    );

    if (currentUser == null ||
        currentUser.userId != activeSession.userId) {
      await ref.read(logoutProvider)(activeSession.refreshToken);
      dio.options.headers.remove('Authorization');
      return null;
    }

    return activeSession;
  }

  Future<AuthSession?> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final loginUser = ref.read(loginProvider);

    final result = await loginUser(email: email, password: password);

    return result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);

        return null;
      },
      (session) {
        final dio = ref.read(apiClientProvider);

        dio.options.headers['Authorization'] = 'Bearer ${session.accessToken}';

        state = AsyncData(session);

        return session;
      },
    );
  }

  Future<void> signOut() async {
    final session = state.asData?.value;

    if (session != null) {
      await ref.read(logoutProvider)(session.refreshToken);
    }

    ref.read(apiClientProvider).options.headers.remove('Authorization');
    state = const AsyncData(null);
  }
}
