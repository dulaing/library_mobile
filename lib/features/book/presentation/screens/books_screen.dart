import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/app_route_names.dart';
import '../providers/book_providers.dart';
import '../widgets/book_list_item.dart';

class BooksScreen extends ConsumerWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksResult = ref.watch(booksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: booksResult.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          final message = error is Failure
              ? error.message
              : 'Something went wrong.';

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 12),
                ElevatedButton(
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
          if (books.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await ref.refresh(booksProvider.future);
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 300,
                    child: Center(child: Text('No books found.')),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.refresh(booksProvider.future);
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];

                return BookListItem(
                  book: book,
                  onTap: () {
                    context.pushNamed(
                      AppRouteNames.bookDetails,
                      pathParameters: {
                        'bookId': book.id.toString(),
                      },
                    );
                  },
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
