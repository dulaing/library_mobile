import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/member.dart';
import '../repositories/member_repository.dart';

class GetMember {
  const GetMember(this.repository);

  final MemberRepository repository;

  Future<Either<Failure, Member>> call(int memberId) {
    return repository.getMember(memberId);
  }
}
