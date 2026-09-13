class CurrentUser {
  const CurrentUser({
    required this.userId,
    required this.email,
    required this.role,
    required this.memberId,
  });

  final int userId;
  final String email;
  final String role;
  final int? memberId;
}