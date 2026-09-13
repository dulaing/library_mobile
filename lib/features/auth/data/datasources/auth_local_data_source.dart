import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/auth_session.dart';
import '../models/auth_session_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveSession(AuthSession session);

  Future<AuthSessionModel?> readSession();

  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this.storage);

  final FlutterSecureStorage storage;

  static const sessionKey = 'auth_session';

  @override
  Future<void> saveSession(AuthSession session) {
    final json = jsonEncode({
      'userId': session.userId,
      'accessToken': session.accessToken,
      'expiresAtUtc': session.expiresAtUtc.toIso8601String(),
      'refreshToken': session.refreshToken,
      'refreshTokenExpiresAtUtc':
      session.refreshTokenExpiresAtUtc.toIso8601String(),
      'role': session.role,
      'memberId': session.memberId,
    });

    return storage.write(key: sessionKey, value: json);
  }

  @override
  Future<AuthSessionModel?> readSession() async {
    final storedJson = await storage.read(key: sessionKey);

    if (storedJson == null) {
      return null;
    }

    final decoded = jsonDecode(storedJson);

    if (decoded is! Map) {
      return null;
    }

    return AuthSessionModel.fromJson(
      Map<String, dynamic>.from(decoded),
    );
  }

  @override
  Future<void> clearSession() {
    return storage.delete(key: sessionKey);
  }
}