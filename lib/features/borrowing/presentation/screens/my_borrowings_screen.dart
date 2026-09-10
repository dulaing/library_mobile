import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/borrowing.dart';
import '../providers/borrowing_providers.dart';

class MyBorrowingsScreen extends ConsumerWidget {
  const MyBorrowingsScreen({
    this.memberId,
    super.key,
  });

  final int? memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMemberId = memberId;

    if (currentMemberId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Borrowings'),
        ),
        body: const Center(
          child: Text(
            'Sign in to view your borrowings.',
          ),
        ),
      );
    }

    final borrowingsResult = ref.watch(
      memberBorrowingsProvider(currentMemberId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Borrowings'),
      ),
      body: borrowingsResult.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
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
                    ref.invalidate(
                      memberBorrowingsProvider(currentMemberId),
                    );
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
                await ref.refresh(
                  memberBorrowingsProvider(
                    currentMemberId,
                  ).future,
                );
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 300,
                    child: Center(
                      child: Text('No borrowings found.'),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.refresh(
                memberBorrowingsProvider(
                  currentMemberId,
                ).future,
              );
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: borrowings.length,
              itemBuilder: (context, index) {
                return BorrowingListItem(
                  borrowing: borrowings[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 1);
              },
            ),
          );
        },
      ),
    );
  }
}

class BorrowingListItem extends StatelessWidget {
  const BorrowingListItem({
    required this.borrowing,
    super.key,
  });

  final Borrowing borrowing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.book_outlined),
      title: Text('Book #${borrowing.bookId}'),
      subtitle: Text(
        'Borrowed: ${formatDate(borrowing.borrowedDate)}\n'
            'Due: ${formatDate(borrowing.dueDate)}',
      ),
      isThreeLine: true,
      trailing: Chip(
        label: Text(borrowing.status),
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