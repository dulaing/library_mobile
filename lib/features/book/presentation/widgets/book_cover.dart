import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/datasources/book_cover_remote_data_source.dart';
import '../providers/book_providers.dart';

// Shows the real cover from Open Library, falling back to a generated one.
// Every cover uses the same size, crop, corners and spine shading so the list looks consistent.
class BookCover extends ConsumerWidget {
  const BookCover({
    required this.title,
    required this.author,
    required this.seed,
    this.width = 56,
    this.height = 80,
    super.key,
  });

  final String title;

  // Without an author the book is unknown (e.g. 'Book #3'), so no lookup is made.
  final String? author;
  final int seed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverResult = author == null
        ? null
        : ref.watch(bookCoverIdProvider(title, author));
    final coverId = coverResult?.asData?.value;
    final isLookingUp = coverResult?.isLoading ?? false;
    final borderRadius = BorderRadius.circular(width * 0.1);

    final generatedCover = _GeneratedCover(
      title: title,
      seed: seed,
      width: width,
    );

    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (isLookingUp || coverId != null)
            ColoredBox(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            )
          else
            generatedCover,
          if (coverId != null)
            Image.network(
              BookCoverRemoteDataSource.coverUrl(coverId, large: width > 80),
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }

                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  child: child,
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return generatedCover;
              },
            ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0x40000000),
                  Color(0x14FFFFFF),
                  Color(0x00000000),
                ],
                stops: [0, 0.06, 0.14],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: const Color(0x1F000000), width: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _GeneratedCover extends StatelessWidget {
  const _GeneratedCover({
    required this.title,
    required this.seed,
    required this.width,
  });

  final String title;
  final int seed;
  final double width;

  static const _palette = [
    Color(0xFF723523),
    Color(0xFF3F5A4A),
    Color(0xFF8A5A2B),
    Color(0xFF4A4E69),
    Color(0xFF9C4A3C),
    Color(0xFF2F4858),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _palette[seed.abs() % _palette.length];
    final trimmedTitle = title.trim();
    final initial = trimmedTitle.isEmpty ? '?' : trimmedTitle[0].toUpperCase();

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, Color.lerp(color, Colors.black, 0.3)!],
        ),
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontFamily: AppTheme.serif,
            fontSize: width * 0.42,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
