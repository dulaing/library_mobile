import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/theme/theme_mode_provider.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/member.dart';
import '../providers/member_providers.dart';

class MemberProfileScreen extends ConsumerStatefulWidget {
  const MemberProfileScreen({super.key});

  @override
  ConsumerState<MemberProfileScreen> createState() {
    return _MemberProfileScreenState();
  }
}

class _MemberProfileScreenState extends ConsumerState<MemberProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  int? loadedMemberId;
  bool isSigningOut = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(authControllerProvider).asData?.value;
    final memberId = session?.memberId;

    if (memberId == null) {
      return const Scaffold(
        body: Center(child: Text('Sign in to view your profile.')),
      );
    }

    final profileResult = ref.watch(memberProfileProvider(memberId));
    final saveState = ref.watch(memberProfileControllerProvider(memberId));
    final selectedTheme = ref.watch(themeModeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: profileResult.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          final message = error is Failure
              ? error.message
              : 'Could not load your profile.';

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    ref.invalidate(memberProfileProvider(memberId));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        data: (member) {
          loadMemberIntoForm(member);

          return Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                _ProfileHeader(member: member),
                const SizedBox(height: 28),
                const _SectionTitle('Personal details'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: fullNameController,
                          decoration: const InputDecoration(
                            labelText: 'Full name',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your name.';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.mail_outline),
                          ),
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              return 'Enter a valid email.';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone number',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: saveState.isLoading
                              ? null
                              : () => saveProfile(member),
                          child: saveState.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Save details'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const _SectionTitle('Account'),
                Card(
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.lock_outline),
                        title: Text('Change password'),
                        subtitle: Text(
                          'Not available yet: the backend has no password-change endpoint.',
                        ),
                      ),
                      const Divider(indent: 16, endIndent: 16),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Log out'),
                        enabled: !isSigningOut,
                        onTap: isSigningOut ? null : signOut,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const _SectionTitle('Appearance'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text('System'),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text('Light'),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text('Dark'),
                        ),
                      ],
                      selected: {selectedTheme},
                      onSelectionChanged: (selection) {
                        ref
                            .read(themeModeControllerProvider.notifier)
                            .changeTheme(selection.first);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void loadMemberIntoForm(Member member) {
    if (loadedMemberId == member.id) {
      return;
    }

    loadedMemberId = member.id;
    fullNameController.text = member.fullName;
    emailController.text = member.email;
    phoneController.text = member.phoneNumber ?? '';
  }

  Future<void> saveProfile(Member member) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final updatedMember = await ref
        .read(memberProfileControllerProvider(member.id).notifier)
        .save(
          fullName: fullNameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim().isEmpty
              ? null
              : phoneController.text.trim(),
          isActive: member.isActive,
        );

    if (!mounted) {
      return;
    }

    if (updatedMember == null) {
      final error = ref.read(memberProfileControllerProvider(member.id)).error;
      final message = error is Failure
          ? error.message
          : 'Could not update your profile.';

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Profile updated.')));
  }

  Future<void> signOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Do you want to log out of this device?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) {
      return;
    }

    setState(() {
      isSigningOut = true;
    });

    await ref.read(authControllerProvider.notifier).signOut();
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final name = member.fullName.trim();

    return Row(
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          child: Text(
            name.isEmpty ? '?' : name[0].toUpperCase(),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colors.onPrimary,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(member.fullName, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 2),
              Text(
                member.email,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
