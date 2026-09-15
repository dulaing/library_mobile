import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/app_route_names.dart';
import '../providers/book_providers.dart';
import '../widgets/book_list_item.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({super.key});

  @override
  ConsumerState<BooksScreen> createState() {
    return _BooksScreenState();
  }
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
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
          final query = searchText.trim().toLowerCase();

          final filteredBooks = books.where((book) {
            return book.title.toLowerCase().contains(query) ||
                book.author.toLowerCase().contains(query) ||
                book.isbn.toLowerCase().contains(query);
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search by title, author, or ISBN',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Text(
                  '${filteredBooks.length} of ${books.length} books',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: filteredBooks.isEmpty
                    ? const Center(child: Text('No matching books found.'))
                    : RefreshIndicator(
                        onRefresh: () async {
                          final _ = await ref.refresh(booksProvider.future);
                        },
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                          itemCount: filteredBooks.length,
                          itemBuilder: (context, index) {
                            final book = filteredBooks[index];

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
                            return const SizedBox(height: 12);
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
