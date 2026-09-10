import '../../domain/entities/auth_session.dart';

class AuthSessionModel extends AuthSession {
  AuthSessionModel({
    required super.userId,
    required super.accessToken,
    required super.expiresAtUtc,
    required super.refreshToken,
    required super.refreshTokenExpiresAtUtc,
    required super.role,
    required super.memberId,
  });

  factory AuthSessionModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return AuthSessionModel(
      userId: json['userId'] as int,
      accessToken: json['accessToken'] as String,
      expiresAtUtc: DateTime.parse(
        json['expiresAtUtc'] as String,
      ),
      refreshToken: json['refreshToken'] as String,
      refreshTokenExpiresAtUtc: DateTime.parse(
        json['refreshTokenExpiresAtUtc'] as String,
      ),
      role: json['role'] as String,
      memberId: json['memberId'] as int?,
    );
  }
}