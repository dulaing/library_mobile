import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final dio = ref.watch(apiClientProvider);

  return AuthRemoteDataSourceImpl(dio);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final dataSource = ref.watch(
    authRemoteDataSourceProvider,
  );

  return AuthRepositoryImpl(dataSource);
}

@riverpod
Login login(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);

  return Login(repository);
}