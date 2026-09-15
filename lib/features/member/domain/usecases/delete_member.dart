import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/member_repository.dart';

class DeleteMember {
  const DeleteMember(this.repository);

  final MemberRepository repository;

  Future<Either<Failure, bool>> call(int memberId) {
    return repository.deleteMember(memberId);
  }
}