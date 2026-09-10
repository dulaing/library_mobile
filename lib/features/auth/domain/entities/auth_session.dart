class AuthSession {
  final int userId;
  final String accessToken;
  final DateTime expiresAtUtc;
  final String refreshToken;
  final DateTime refreshTokenExpiresAtUtc;
  final String role;
  final int? memberId;

  AuthSession({
    required this.userId,
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
    required this.refreshTokenExpiresAtUtc,
    required this.role,
    required this.memberId,
  });

  bool get accessTokenIsExpired {
    return DateTime.now().toUtc().isAfter(expiresAtUtc);
  }
}