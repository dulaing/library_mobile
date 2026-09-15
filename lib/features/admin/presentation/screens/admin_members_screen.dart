import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../member/presentation/providers/member_providers.dart';

class AdminMembersScreen extends ConsumerWidget {
  const AdminMembersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersResult = ref.watch(membersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Members'),
      ),
      body: membersResult.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          final message = error is Failure
              ? error.message
              : 'Could not load members.';

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    ref.invalidate(membersProvider);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        data: (members) {
          if (members.isEmpty) {
            return const Center(
              child: Text('No members found.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(membersProvider);
              await ref.read(membersProvider.future);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: members.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
              itemBuilder: (context, index) {
                final member = members[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        member.fullName.isEmpty
                            ? '?'
                            : member.fullName[0].toUpperCase(),
                      ),
                    ),
                    title: Text(member.fullName),
                    subtitle: Text(
                      '${member.email}\n'
                          '${member.phoneNumber ?? 'No phone number'}',
                    ),
                    isThreeLine: true,
                    trailing: Chip(
                      label: Text(
                        member.isActive ? 'Active' : 'Inactive',
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}