import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/member_remote_data_source.dart';
import '../../data/repositories/member_repository_impl.dart';
import '../../domain/entities/member.dart';
import '../../domain/repositories/member_repository.dart';
import '../../domain/usecases/get_member.dart';
import '../../domain/usecases/update_member.dart';

part 'member_providers.g.dart';

@riverpod
MemberRemoteDataSource memberRemoteDataSource(Ref ref) {
  return MemberRemoteDataSourceImpl(ref.watch(apiClientProvider));
}

@riverpod
MemberRepository memberRepository(Ref ref) {
  return MemberRepositoryImpl(ref.watch(memberRemoteDataSourceProvider));
}

@riverpod
GetMember getMember(Ref ref) {
  return GetMember(ref.watch(memberRepositoryProvider));
}

@riverpod
UpdateMember updateMember(Ref ref) {
  return UpdateMember(ref.watch(memberRepositoryProvider));
}

@Riverpod(retry: noMemberRetry)
Future<Member> memberProfile(Ref ref, int memberId) async {
  final result = await ref.watch(getMemberProvider)(memberId);

  return result.fold((failure) => throw failure, (member) => member);
}

@riverpod
class MemberProfileController extends _$MemberProfileController {
  @override
  FutureOr<void> build(int memberId) {}

  Future<Member?> save({
    required String fullName,
    required String email,
    required String? phoneNumber,
    required bool isActive,
  }) async {
    state = const AsyncLoading();

    final result = await ref.read(updateMemberProvider)(
      memberId: memberId,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      isActive: isActive,
    );

    return result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        return null;
      },
      (member) {
        ref.invalidate(memberProfileProvider(memberId));
        state = const AsyncData(null);
        return member;
      },
    );
  }
}

Duration? noMemberRetry(int retryCount, Object error) {
  return null;
}
