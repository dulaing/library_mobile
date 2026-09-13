import '../../domain/entities/current_user.dart';

class CurrentUserModel extends CurrentUser {
  const CurrentUserModel({
    required super.userId,
    required super.email,
    required super.role,
    required super.memberId,
  });

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      userId: json['userId'] as int,
      email: json['email'] as String,
      role: json['role'] as String,
      memberId: json['memberId'] as int?,
    );
  }
}