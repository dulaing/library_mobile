// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider = AuthRemoteDataSourceProvider._();

final class AuthRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDataSource,
          AuthRemoteDataSource,
          AuthRemoteDataSource
        >
    with $Provider<AuthRemoteDataSource> {
  AuthRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDataSource create(Ref ref) {
    return authRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSource>(value),
    );
  }
}

String _$authRemoteDataSourceHash() =>
    r'8473ae966c203c9044a29cbc83cf1fbd8962b419';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'adc39ccadd9c1cd74cbb0280ec05cc61f167a6f9';

@ProviderFor(login)
final loginProvider = LoginProvider._();

final class LoginProvider extends $FunctionalProvider<Login, Login, Login>
    with $Provider<Login> {
  LoginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginHash();

  @$internal
  @override
  $ProviderElement<Login> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Login create(Ref ref) {
    return login(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Login value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Login>(value),
    );
  }
}

String _$loginHash() => r'dd1058fbf218798b084cca91e4b965806a8055bf';

@ProviderFor(logout)
final logoutProvider = LogoutProvider._();

final class LogoutProvider extends $FunctionalProvider<Logout, Logout, Logout>
    with $Provider<Logout> {
  LogoutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoutProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoutHash();

  @$internal
  @override
  $ProviderElement<Logout> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Logout create(Ref ref) {
    return logout(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Logout value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Logout>(value),
    );
  }
}

String _$logoutHash() => r'cbcd2b52a07afaac9349343df36c4518410024ad';

@ProviderFor(refreshSession)
final refreshSessionProvider = RefreshSessionProvider._();

final class RefreshSessionProvider
    extends $FunctionalProvider<RefreshSession, RefreshSession, RefreshSession>
    with $Provider<RefreshSession> {
  RefreshSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refreshSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refreshSessionHash();

  @$internal
  @override
  $ProviderElement<RefreshSession> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RefreshSession create(Ref ref) {
    return refreshSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RefreshSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RefreshSession>(value),
    );
  }
}

String _$refreshSessionHash() => r'1b2fe416398e0e09f505e2e643856113040f0ba7';

@ProviderFor(getCurrentUser)
final getCurrentUserProvider = GetCurrentUserProvider._();

final class GetCurrentUserProvider
    extends $FunctionalProvider<GetCurrentUser, GetCurrentUser, GetCurrentUser>
    with $Provider<GetCurrentUser> {
  GetCurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCurrentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCurrentUserHash();

  @$internal
  @override
  $ProviderElement<GetCurrentUser> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetCurrentUser create(Ref ref) {
    return getCurrentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCurrentUser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCurrentUser>(value),
    );
  }
}

String _$getCurrentUserHash() => r'1a2852689c2010e44c171e226239a571eef58a5a';

@ProviderFor(restoreSession)
final restoreSessionProvider = RestoreSessionProvider._();

final class RestoreSessionProvider
    extends $FunctionalProvider<RestoreSession, RestoreSession, RestoreSession>
    with $Provider<RestoreSession> {
  RestoreSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restoreSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restoreSessionHash();

  @$internal
  @override
  $ProviderElement<RestoreSession> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RestoreSession create(Ref ref) {
    return restoreSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestoreSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestoreSession>(value),
    );
  }
}

String _$restoreSessionHash() => r'4e4378a744e34fe266949fb4107362c651238618';

@ProviderFor(authLocalDataSource)
final authLocalDataSourceProvider = AuthLocalDataSourceProvider._();

final class AuthLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AuthLocalDataSource,
          AuthLocalDataSource,
          AuthLocalDataSource
        >
    with $Provider<AuthLocalDataSource> {
  AuthLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthLocalDataSource create(Ref ref) {
    return authLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthLocalDataSource>(value),
    );
  }
}

String _$authLocalDataSourceHash() =>
    r'c5fe79a873c29236d1c7e15bd32d8169675aea8d';

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, AuthSession?> {
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'8e79191a9a55de00c2b9e8d41c7f8b5894b60dcb';

abstract class _$AuthController extends $AsyncNotifier<AuthSession?> {
  FutureOr<AuthSession?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AuthSession?>, AuthSession?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthSession?>, AuthSession?>,
              AsyncValue<AuthSession?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
