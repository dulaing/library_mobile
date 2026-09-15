import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/member.dart';
import '../repositories/member_repository.dart';

class GetMembers {
  const GetMembers(this.repository);

  final MemberRepository repository;

  Future<Either<Failure, List<Member>>> call() {
    return repository.getMembers();
  }
}