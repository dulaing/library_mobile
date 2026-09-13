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

    return Scaffold(
      appBar: AppBar(title: const Text('Book Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(book.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(book.author, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: const Text('ISBN'),
            subtitle: Text(book.isbn),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Published year'),
            subtitle: Text(book.publishedYear.toString()),
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text('Total copies'),
            subtitle: Text(book.totalCopies.toString()),
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Available copies'),
            subtitle: Text(book.availableCopies.toString()),
          ),
          const SizedBox(height: 16),
          Text(
            isAvailable
                ? 'This book is available.'
                : 'This book is currently unavailable.',
            style: TextStyle(
              color: isAvailable ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
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

String formatDate(DateTime date) {
  final localDate = date.toLocal();
  final month = localDate.month.toString().padLeft(2, '0');
  final day = localDate.day.toString().padLeft(2, '0');

  return '${localDate.year}-$month-$day';
}
