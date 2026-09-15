import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/status_pill.dart';
import '../../domain/entities/book.dart';

class BookAvailabilityPill extends StatelessWidget {
  const BookAvailabilityPill({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isAvailable = book.availableCopies > 0;

    return StatusPill(
      label: isAvailable ? '${book.availableCopies} available' : 'Unavailable',
      color: isAvailable ? colors.success : colors.error,
    );
  }
}
