import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/borrowing.dart';
import '../providers/borrowing_providers.dart';

import '../../../book/domain/entities/book.dart';
import '../../../book/presentation/providers/book_providers.dart';

class MyBorrowingsScreen extends ConsumerWidget {
  const MyBorrowingsScreen({this.memberId, super.key});

  final int? memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMemberId = memberId;

    if (currentMemberId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Borrowings')),
        body: const Center(child: Text('Sign in to view your borrowings.')),
      );
    }

    final borrowingsResult = ref.watch(
      memberBorrowingsProvider(currentMemberId),
    );

    final booksResult = ref.watch(booksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Borrowings')),
      body: borrowingsResult.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          final message = error is Failure
              ? error.message
              : 'Could not load your borrowings.';

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    ref.invalidate(memberBorrowingsProvider(currentMemberId));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        data: (borrowings) {
          if (borrowings.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                final _ = await ref.refresh(
                  memberBorrowingsProvider(currentMemberId).future,
                );
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 300,
                    child: Center(child: Text('No borrowings found.')),
                  ),
                ],
              ),
            );
          }

          return booksResult.when(
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Could not load book information.'),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () {
                        ref.invalidate(booksProvider);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            },
            data: (books) {
              final booksById = {for (final book in books) book.id: book};

              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(booksProvider);

                  final _ = await ref.refresh(
                    memberBorrowingsProvider(currentMemberId).future,
                  );
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: borrowings.length,
                  itemBuilder: (context, index) {
                    final borrowing = borrowings[index];

                    return BorrowingListItem(
                      borrowing: borrowing,
                      book: booksById[borrowing.bookId],
                      memberId: currentMemberId,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(height: 1);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BorrowingListItem extends ConsumerWidget {
  const BorrowingListItem({
    required this.borrowing,
    required this.book,
    required this.memberId,
    super.key,
  });

  final Borrowing borrowing;
  final Book? book;
  final int memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBook = book;
    final isActive =
        borrowing.returnedDate == null &&
        borrowing.status.toLowerCase() != 'returned';
    final returnState = ref.watch(returnBookControllerProvider(borrowing.id));

    return ListTile(
      leading: const Icon(Icons.book_outlined),
      title: Text(currentBook?.title ?? 'Book #${borrowing.bookId}'),
      subtitle: Text(
        [
          if (currentBook != null) currentBook.author,
          'Borrowed: ${formatDate(borrowing.borrowedDate)}',
          'Due: ${formatDate(borrowing.dueDate)}',
        ].join('\n'),
      ),
      isThreeLine: true,
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(label: Text(borrowing.status)),
          if (isActive)
            TextButton(
              onPressed: returnState.isLoading
                  ? null
                  : () => confirmAndReturn(context, ref),
              child: Text(returnState.isLoading ? 'Returning...' : 'Return'),
            ),
        ],
      ),
    );
  }

  Future<void> confirmAndReturn(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
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
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final returnedBorrowing = await ref
        .read(returnBookControllerProvider(borrowing.id).notifier)
        .submit(memberId: memberId);

    if (!context.mounted) {
      return;
    }

    if (returnedBorrowing == null) {
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

String formatDate(DateTime date) {
  final localDate = date.toLocal();
  final month = localDate.month.toString().padLeft(2, '0');
  final day = localDate.day.toString().padLeft(2, '0');

  return '${localDate.year}-$month-$day';
}
