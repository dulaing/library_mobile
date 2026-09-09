import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme_mode_provider.dart';

class MemberProfileScreen extends ConsumerWidget {
  const MemberProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // reads the current value and rebuilds the Profile screen when it changes
    final selectedTheme = ref.watch(themeModeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Member profile data is not connected yet.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
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
              final newTheme = selection.first;

              // This gets the controller so we can call its function
              ref.read(themeModeControllerProvider.notifier).changeTheme(newTheme);
            },
          ),
        ],
      ),
    );
  }
}