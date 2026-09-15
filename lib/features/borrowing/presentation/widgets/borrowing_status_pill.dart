import 'package:flutter/material.dart';

import '../../../../core/widgets/status_pill.dart';
import '../../domain/entities/borrowing.dart';

class BorrowingStatusPill extends StatelessWidget {
  const BorrowingStatusPill({required this.borrowing, super.key});

  final Borrowing borrowing;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final status = borrowing.status.toLowerCase();

    final color = borrowing.returnedDate != null || status == 'returned'
        ? colors.outline
        : status == 'overdue'
        ? colors.error
        : colors.primary;

    return StatusPill(label: borrowing.status, color: color);
  }
}
