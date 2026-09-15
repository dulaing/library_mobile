import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -40,
            child: DecorativeCircle(
              size: 170,
              color: colors.onPrimary.withValues(alpha: 0.08),
            ),
          ),
          Positioned(
            bottom: -60,
            right: 60,
            child: DecorativeCircle(
              size: 110,
              color: colors.onPrimary.withValues(alpha: 0.06),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.onPrimary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: colors.onPrimary),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colors.onPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DecorativeCircle extends StatelessWidget {
  const DecorativeCircle({required this.size, required this.color, super.key});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
