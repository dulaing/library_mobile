import 'package:fpdart/fpdart.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/member.dart';
import '../../domain/repositories/member_repository.dart';
import '../datasources/member_remote_data_source.dart';

class MemberRepositoryImpl implements MemberRepository {
  const MemberRepositoryImpl(this.dataSource);

  final MemberRemoteDataSource dataSource;

  @override
  Future<Either<Failure, Member>> getMember(int memberId) async {
    try {
      return Right(await dataSource.getMember(memberId));
    } on ApiException catch (error) {
      return Left(MemberFailure(error.message));
    } catch (_) {
      return const Left(MemberFailure('Could not load your profile.'));
    }
  }

  @override
  Future<Either<Failure, Member>> updateMember({
    required int memberId,
    required String fullName,
    required String email,
    required String? phoneNumber,
    required bool isActive,
  }) async {
    try {
      final member = await dataSource.updateMember(
        memberId: memberId,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        isActive: isActive,
      );

      return Right(member);
    } on ApiException catch (error) {
      return Left(MemberFailure(error.message));
    } catch (_) {
      return const Left(MemberFailure('Could not update your profile.'));
    }
  }
}
