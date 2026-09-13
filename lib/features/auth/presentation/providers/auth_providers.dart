import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/refresh_session.dart';
import '../../domain/entities/auth_session.dart';


part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final dio = ref.watch(apiClientProvider);

  return AuthRemoteDataSourceImpl(dio);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final dataSource = ref.watch(authRemoteDataSourceProvider);

  return AuthRepositoryImpl(dataSource);
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

// controller that performs login and remembers its current state.
// keepAlive: true means Riverpod keeps the logged-in session in memory while the app is running.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AuthSession?> build() async {
    return null;
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
