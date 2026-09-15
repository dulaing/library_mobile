import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/app_route_names.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../borrowing/domain/entities/borrowing.dart';
import '../../../borrowing/presentation/providers/borrowing_providers.dart';
import '../../domain/entities/book.dart';
import '../providers/book_providers.dart';
import '../widgets/book_availability_pill.dart';
import '../widgets/book_cover.dart';

class BookDetailsScreen extends ConsumerWidget {
  const BookDetailsScreen({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAvailable = book.availableCopies > 0;
    final memberId = ref.watch(authControllerProvider).asData?.value?.memberId;
    final borrowState = ref.watch(borrowBookControllerProvider(book.id));
    final borrowError = borrowState.error;
    final errorMessage = borrowError is Failure ? borrowError.message : null;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Details')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        children: [
          Center(
            child: BookCover(
              title: book.title,
              author: book.author,
              seed: book.id,
              width: 132,
              height: 188,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            book.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 6),
          Text(
            book.author,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          Center(child: BookAvailabilityPill(book: book)),
          const SizedBox(height: 28),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _DetailTile(
                          icon: Icons.numbers,
                          label: 'ISBN',
                          value: book.isbn,
                        ),
                      ),
                      Expanded(
                        child: _DetailTile(
                          icon: Icons.calendar_today_outlined,
                          label: 'Published year',
                          value: book.publishedYear.toString(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _DetailTile(
                          icon: Icons.inventory_2_outlined,
                          label: 'Total copies',
                          value: book.totalCopies.toString(),
                        ),
                      ),
                      Expanded(
                        child: _DetailTile(
                          icon: Icons.library_books_outlined,
                          label: 'Available copies',
                          value: book.availableCopies.toString(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: isAvailable && memberId != null && !borrowState.isLoading
                ? () => confirmAndBorrow(
                    context: context,
                    ref: ref,
                    memberId: memberId,
                  )
                : null,
            icon: borrowState.isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.library_add),
            label: Text(
              borrowState.isLoading
                  ? 'Borrowing...'
                  : isAvailable
                  ? 'Borrow this book'
                  : 'Book unavailable',
            ),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> confirmAndBorrow({
    required BuildContext context,
    required WidgetRef ref,
    required int memberId,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Confirm borrowing'),
          content: Text(
            'Borrow "${book.title}"? The library will set the due date.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final borrowing = await ref
        .read(borrowBookControllerProvider(book.id).notifier)
        .submit(memberId: memberId);

    if (!context.mounted) {
      return;
    }

    if (borrowing == null) {
      await showBorrowingError(context, ref);
      return;
    }

    final viewBorrowings = await showBorrowingSuccess(
      context,
      borrowing,
    );

    ref.invalidate(booksProvider);
    ref.invalidate(bookProvider(book.id));

    if (context.mounted && viewBorrowings) {
      context.goNamed(AppRouteNames.borrowings);
    }
  }

  Future<void> showBorrowingError(BuildContext context, WidgetRef ref) async {
    final error = ref.read(borrowBookControllerProvider(book.id)).error;
    final message = error is Failure
        ? error.message
        : 'Could not borrow this book.';

    final viewBorrowings = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Unable to borrow'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('View my borrowings'),
            ),
          ],
        );
      },
    );

    if (context.mounted && viewBorrowings == true) {
      context.goNamed(AppRouteNames.borrowings);
    }
  }

  Future<bool> showBorrowingSuccess(
    BuildContext context,
    Borrowing borrowing,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Book borrowed'),
          content: Text(
            'Your borrowing was created successfully.\n\n'
            'Due date: ${formatDate(borrowing.dueDate)}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Stay here'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('View my borrowings'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: colors.onPrimaryContainer),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
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

String formatDate(DateTime date) {
  final localDate = date.toLocal();
  final month = localDate.month.toString().padLeft(2, '0');
  final day = localDate.day.toString().padLeft(2, '0');

  return '${localDate.year}-$month-$day';
}
