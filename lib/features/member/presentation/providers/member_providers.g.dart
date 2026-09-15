// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(memberRemoteDataSource)
final memberRemoteDataSourceProvider = MemberRemoteDataSourceProvider._();

final class MemberRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          MemberRemoteDataSource,
          MemberRemoteDataSource,
          MemberRemoteDataSource
        >
    with $Provider<MemberRemoteDataSource> {
  MemberRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memberRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memberRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<MemberRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MemberRemoteDataSource create(Ref ref) {
    return memberRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MemberRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MemberRemoteDataSource>(value),
    );
  }
}

String _$memberRemoteDataSourceHash() =>
    r'0a02b7677c289b311fc5c947540dd9bb56feb7cf';

@ProviderFor(memberRepository)
final memberRepositoryProvider = MemberRepositoryProvider._();

final class MemberRepositoryProvider
    extends
        $FunctionalProvider<
          MemberRepository,
          MemberRepository,
          MemberRepository
        >
    with $Provider<MemberRepository> {
  MemberRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memberRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memberRepositoryHash();

  @$internal
  @override
  $ProviderElement<MemberRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MemberRepository create(Ref ref) {
    return memberRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MemberRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MemberRepository>(value),
    );
  }
}

String _$memberRepositoryHash() => r'8c0ecd2c8c99a35712b1bec094ebf79e080a9e5b';

@ProviderFor(getMember)
final getMemberProvider = GetMemberProvider._();

final class GetMemberProvider
    extends $FunctionalProvider<GetMember, GetMember, GetMember>
    with $Provider<GetMember> {
  GetMemberProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMemberProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMemberHash();

  @$internal
  @override
  $ProviderElement<GetMember> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetMember create(Ref ref) {
    return getMember(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMember value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMember>(value),
    );
  }
}

String _$getMemberHash() => r'179a30ff84064bb48e896954a282c6a15b8d0a74';

@ProviderFor(updateMember)
final updateMemberProvider = UpdateMemberProvider._();

final class UpdateMemberProvider
    extends $FunctionalProvider<UpdateMember, UpdateMember, UpdateMember>
    with $Provider<UpdateMember> {
  UpdateMemberProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateMemberProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateMemberHash();

  @$internal
  @override
  $ProviderElement<UpdateMember> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateMember create(Ref ref) {
    return updateMember(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateMember value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateMember>(value),
    );
  }
}

String _$updateMemberHash() => r'de6edfa97e6b049a2889c2cc4b298d29924b57ef';

@ProviderFor(getMembers)
final getMembersProvider = GetMembersProvider._();

final class GetMembersProvider
    extends $FunctionalProvider<GetMembers, GetMembers, GetMembers>
    with $Provider<GetMembers> {
  GetMembersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMembersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMembersHash();

  @$internal
  @override
  $ProviderElement<GetMembers> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetMembers create(Ref ref) {
    return getMembers(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMembers value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMembers>(value),
    );
  }
}

String _$getMembersHash() => r'3f9ce761d1330cebcbd332a7b6c99815cf9d251f';

@ProviderFor(members)
final membersProvider = MembersProvider._();

final class MembersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Member>>,
          List<Member>,
          FutureOr<List<Member>>
        >
    with $FutureModifier<List<Member>>, $FutureProvider<List<Member>> {
  MembersProvider._()
    : super(
        from: null,
        argument: null,
        retry: noMemberRetry,
        name: r'membersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membersHash();

  @$internal
  @override
  $FutureProviderElement<List<Member>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Member>> create(Ref ref) {
    return members(ref);
  }
}

String _$membersHash() => r'5e08e725a96b0407208a1a9474f8ae24930d7aee';

@ProviderFor(memberProfile)
final memberProfileProvider = MemberProfileFamily._();

final class MemberProfileProvider
    extends $FunctionalProvider<AsyncValue<Member>, Member, FutureOr<Member>>
    with $FutureModifier<Member>, $FutureProvider<Member> {
  MemberProfileProvider._({
    required MemberProfileFamily super.from,
    required int super.argument,
  }) : super(
         retry: noMemberRetry,
         name: r'memberProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberProfileHash();

  @override
  String toString() {
    return r'memberProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Member> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Member> create(Ref ref) {
    final argument = this.argument as int;
    return memberProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MemberProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberProfileHash() => r'13e2c0a2d55e42491e58405b06dacf37644a846d';

final class MemberProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Member>, int> {
  MemberProfileFamily._()
    : super(
        retry: noMemberRetry,
        name: r'memberProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberProfileProvider call(int memberId) =>
      MemberProfileProvider._(argument: memberId, from: this);

  @override
  String toString() => r'memberProfileProvider';
}

@ProviderFor(MemberProfileController)
final memberProfileControllerProvider = MemberProfileControllerFamily._();

final class MemberProfileControllerProvider
    extends $AsyncNotifierProvider<MemberProfileController, void> {
  MemberProfileControllerProvider._({
    required MemberProfileControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'memberProfileControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberProfileControllerHash();

  @override
  String toString() {
    return r'memberProfileControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MemberProfileController create() => MemberProfileController();

  @override
  bool operator ==(Object other) {
    return other is MemberProfileControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberProfileControllerHash() =>
    r'ac7748cd8ec0e9b3c8cdf6d82dff694e80fc8a21';

final class MemberProfileControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MemberProfileController,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  MemberProfileControllerFamily._()
    : super(
        retry: null,
        name: r'memberProfileControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberProfileControllerProvider call(int memberId) =>
      MemberProfileControllerProvider._(argument: memberId, from: this);

  @override
  String toString() => r'memberProfileControllerProvider';
}

abstract class _$MemberProfileController extends $AsyncNotifier<void> {
  late final _$args = ref.$arg as int;
  int get memberId => _$args;

  FutureOr<void> build(int memberId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
