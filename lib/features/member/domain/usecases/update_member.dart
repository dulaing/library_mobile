import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/member.dart';
import '../repositories/member_repository.dart';

class UpdateMember {
  const UpdateMember(this.repository);

  final MemberRepository repository;

  Future<Either<Failure, Member>> call({
    required int memberId,
    required String fullName,
    required String email,
    required String? phoneNumber,
    required bool isActive,
  }) {
    return repository.updateMember(
      memberId: memberId,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      isActive: isActive,
    );
  }
}
