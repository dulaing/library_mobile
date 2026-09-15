import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/hero_card.dart';

class MemberHomeScreen extends StatelessWidget {
  const MemberHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          const HeroCard(
            icon: Icons.local_library_outlined,
            title: 'Welcome to the Library',
            subtitle:
                'Browse the catalog, borrow a book and keep track of '
                'what is due.',
          ),
          const SizedBox(height: 40),
          Icon(Icons.format_quote_rounded, color: colors.outline),
          const SizedBox(height: 8),
          Text(
            '"A library is not a luxury but one of the necessities of life."',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: AppTheme.serif,
              fontStyle: FontStyle.italic,
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'HENRY WARD BEECHER',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              letterSpacing: 1.2,
              color: colors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
