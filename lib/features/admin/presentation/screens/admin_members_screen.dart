import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../borrowing/presentation/screens/my_borrowings_screen.dart';
import '../../../member/domain/entities/member.dart';
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
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_errorMessage(error)),
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
                          '${member.phoneNumber ?? 'No phone number'}\n'
                          '${member.isActive ? 'Active' : 'Inactive'}',
                    ),
                    isThreeLine: true,
                    trailing: PopupMenuButton<MemberAction>(
                      onSelected: (action) {
                        switch (action) {
                          case MemberAction.edit:
                            _editMember(context, ref, member);

                          case MemberAction.borrowings:
                            _viewBorrowings(context, member);
                        }
                      },
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            value: MemberAction.edit,
                            child: ListTile(
                              leading: Icon(Icons.edit_outlined),
                              title: Text('Edit'),
                            ),
                          ),
                          PopupMenuItem(
                            value: MemberAction.borrowings,
                            child: ListTile(
                              leading: Icon(Icons.history),
                              title: Text('View borrowings'),
                            ),
                          ),
                        ];
                      },
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

  Future<void> _editMember(
      BuildContext context,
      WidgetRef ref,
      Member member,
      ) async {
    final formData = await showDialog<MemberFormData>(
      context: context,
      builder: (context) {
        return EditMemberDialog(member: member);
      },
    );

    if (formData == null || !context.mounted) {
      return;
    }

    final updatedMember = await ref
        .read(memberProfileControllerProvider(member.id).notifier)
        .save(
      fullName: formData.fullName,
      email: formData.email,
      phoneNumber: formData.phoneNumber,
      isActive: formData.isActive,
    );

    if (!context.mounted) {
      return;
    }

    if (updatedMember == null) {
      final error = ref
          .read(memberProfileControllerProvider(member.id))
          .error;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage(error))),
      );

      return;
    }

    ref.invalidate(membersProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Member updated.'),
      ),
    );
  }

  void _viewBorrowings(
      BuildContext context,
      Member member,
      ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MyBorrowingsScreen(
            memberId: member.id,
            title: '${member.fullName} Borrowings',
          );
        },
      ),
    );
  }

  String _errorMessage(Object? error) {
    if (error is Failure) {
      return error.message;
    }

    return 'Something went wrong.';
  }
}

enum MemberAction {
  edit,
  borrowings,
}

class EditMemberDialog extends StatefulWidget {
  const EditMemberDialog({
    required this.member,
    super.key,
  });

  final Member member;

  @override
  State<EditMemberDialog> createState() {
    return _EditMemberDialogState();
  }
}

class _EditMemberDialogState extends State<EditMemberDialog> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  late bool isActive;

  @override
  void initState() {
    super.initState();

    fullNameController = TextEditingController(
      text: widget.member.fullName,
    );

    emailController = TextEditingController(
      text: widget.member.email,
    );

    phoneController = TextEditingController(
      text: widget.member.phoneNumber ?? '',
    );

    isActive = widget.member.isActive;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit member'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter the member name.';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Enter a valid email.';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Active member'),
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final phone = phoneController.text.trim();

    Navigator.pop(
      context,
      MemberFormData(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phone.isEmpty ? null : phone,
        isActive: isActive,
      ),
    );
  }
}

class MemberFormData {
  const MemberFormData({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.isActive,
  });

  final String fullName;
  final String email;
  final String? phoneNumber;
  final bool isActive;
}