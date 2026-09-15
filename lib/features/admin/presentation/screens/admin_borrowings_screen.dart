import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../book/domain/entities/book.dart';
import '../../../book/presentation/providers/book_providers.dart';
import '../../../borrowing/domain/entities/borrowing.dart';
import '../../../borrowing/presentation/providers/borrowing_providers.dart';
import '../../../member/domain/entities/member.dart';
import '../../../member/presentation/providers/member_providers.dart';

class AdminBorrowingsScreen extends ConsumerWidget {
  const AdminBorrowingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borrowingsResult = ref.watch(allBorrowingsProvider);
    final booksResult = ref.watch(booksProvider);
    final membersResult = ref.watch(membersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Borrowings')),
      body: borrowingsResult.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _ErrorView(
          message: _errorMessage(error),
          onRetry: () => ref.invalidate(allBorrowingsProvider),
        ),
        data: (borrowings) {
          if (borrowings.isEmpty) {
            return const Center(child: Text('No borrowings found.'));
          }

          return booksResult.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => _ErrorView(
              message: 'Could not load book information.',
              onRetry: () => ref.invalidate(booksProvider),
            ),
            data: (books) {
              return membersResult.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => _ErrorView(
                  message: 'Could not load member information.',
                  onRetry: () => ref.invalidate(membersProvider),
                ),
                data: (members) {
                  final booksById = {for (final book in books) book.id: book};
                  final membersById = {
                    for (final member in members) member.id: member,
                  };

                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(booksProvider);
                      ref.invalidate(membersProvider);
                      final _ = await ref.refresh(allBorrowingsProvider.future);
                    },
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: borrowings.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final borrowing = borrowings[index];

                        return _AdminBorrowingCard(
                          borrowing: borrowing,
                          book: booksById[borrowing.bookId],
                          member: membersById[borrowing.memberId],
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _errorMessage(Object error) {
    return error is Failure ? error.message : 'Could not load borrowings.';
  }
}

class _AdminBorrowingCard extends ConsumerWidget {
  const _AdminBorrowingCard({
    required this.borrowing,
    required this.book,
    required this.member,
  });

  final Borrowing borrowing;
  final Book? book;
  final Member? member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive =
        borrowing.returnedDate == null &&
        borrowing.status.toLowerCase() != 'returned';
    final returnState = ref.watch(returnBookControllerProvider(borrowing.id));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book?.title ?? 'Book #${borrowing.bookId}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(member?.fullName ?? 'Member #${borrowing.memberId}'),
            const SizedBox(height: 8),
            Text('Borrowed: ${_formatDate(borrowing.borrowedDate)}'),
            Text('Due: ${_formatDate(borrowing.dueDate)}'),
            if (borrowing.returnedDate != null)
              Text('Returned: ${_formatDate(borrowing.returnedDate!)}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(borrowing.status)),
                if (isActive)
                  TextButton(
                    onPressed: returnState.isLoading
                        ? null
                        : () => _returnBook(context, ref),
                    child: Text(
                      returnState.isLoading ? 'Returning...' : 'Return',
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _returnBook(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Return book'),
        content: Text(
          'Mark "${book?.title ?? 'Book #${borrowing.bookId}'}" as returned?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Return'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final returned = await ref
        .read(returnBookControllerProvider(borrowing.id).notifier)
        .submit(memberId: borrowing.memberId);

    if (!context.mounted) {
      return;
    }

    if (returned == null) {
      final error = ref.read(returnBookControllerProvider(borrowing.id)).error;
      final message = error is Failure
          ? error.message
          : 'Could not return this book.';

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      return;
    }

    ref.invalidate(booksProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Book returned successfully.')),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final localDate = date.toLocal();
  final month = localDate.month.toString().padLeft(2, '0');
  final day = localDate.day.toString().padLeft(2, '0');

  return '${localDate.year}-$month-$day';
}
