import '../../domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.registeredDate,
    required super.isActive,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      registeredDate: DateTime.parse(json['registeredDate'] as String),
      isActive: json['isActive'] as bool,
    );
  }
}
