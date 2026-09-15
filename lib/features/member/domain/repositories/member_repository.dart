import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/member.dart';

abstract class MemberRepository {
  Future<Either<Failure, Member>> getMember(int memberId);

  Future<Either<Failure, Member>> updateMember({
    required int memberId,
    required String fullName,
    required String email,
    required String? phoneNumber,
    required bool isActive,
  });

  Future<Either<Failure, List<Member>>> getMembers();

  Future<Either<Failure, Member>> createMemberAccount({
    required String fullName,
    required String email,
    required String? phoneNumber,
    required String password,
  });
}
