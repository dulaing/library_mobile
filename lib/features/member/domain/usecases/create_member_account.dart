import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/member.dart';
import '../repositories/member_repository.dart';

class CreateMemberAccount {
  const CreateMemberAccount(this.repository);

  final MemberRepository repository;

  Future<Either<Failure, Member>> call({
    required String fullName,
    required String email,
    required String? phoneNumber,
    required String password,
  }) {
    return repository.createMemberAccount(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}