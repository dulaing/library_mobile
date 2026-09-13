import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class RestoreSession {
  const RestoreSession(this.repository);

  final AuthRepository repository;

  Future<AuthSession?> call() {
    return repository.restoreSession();
  }
}