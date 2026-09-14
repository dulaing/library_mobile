import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../book/domain/entities/book.dart';
import '../../../book/presentation/providers/book_providers.dart';

class AdminBooksScreen extends ConsumerWidget {
  const AdminBooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksResult = ref.watch(booksProvider);
    final mutationState = ref.watch(adminBookControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Books'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: mutationState.isLoading
            ? null
            : () => _openBookForm(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add book'),
      ),
      body: booksResult.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_errorMessage(error)),
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
          if (books.isEmpty) {
            return const Center(
              child: Text('No books found.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(booksProvider);
              await ref.read(booksProvider.future);
            },
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: books.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
              itemBuilder: (context, index) {
                final book = books[index];

                return Card(
                  child: ListTile(
                    title: Text(book.title),
                    subtitle: Text(
                      '${book.author}\n'
                          'Available: ${book.availableCopies}/${book.totalCopies}',
                    ),
                    isThreeLine: true,
                    trailing: PopupMenuButton<String>(
                      enabled: !mutationState.isLoading,
                      onSelected: (action) {
                        if (action == 'edit') {
                          _openBookForm(
                            context,
                            ref,
                            book: book,
                          );
                        }

                        if (action == 'delete') {
                          _confirmDelete(
                            context,
                            ref,
                            book,
                          );
                        }
                      },
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ];
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _openBookForm(
      BuildContext context,
      WidgetRef ref, {
        Book? book,
      }) async {
    final formData = await showDialog<BookFormData>(
      context: context,
      builder: (context) {
        return BookFormDialog(book: book);
      },
    );

    if (formData == null || !context.mounted) {
      return;
    }

    Book? savedBook;

    if (book == null) {
      savedBook = await ref
          .read(adminBookControllerProvider.notifier)
          .create(
        title: formData.title,
        author: formData.author,
        isbn: formData.isbn,
        publishedYear: formData.publishedYear,
        totalCopies: formData.totalCopies,
      );
    } else {
      savedBook = await ref
          .read(adminBookControllerProvider.notifier)
          .updateBook(
        bookId: book.id,
        title: formData.title,
        author: formData.author,
        isbn: formData.isbn,
        publishedYear: formData.publishedYear,
        totalCopies: formData.totalCopies,
      );
    }

    if (!context.mounted) {
      return;
    }

    if (savedBook == null) {
      final error = ref.read(adminBookControllerProvider).error;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage(error))),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          book == null ? 'Book added.' : 'Book updated.',
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context,
      WidgetRef ref,
      Book book,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete book'),
          content: Text(
            'Delete "${book.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final deleted = await ref
        .read(adminBookControllerProvider.notifier)
        .delete(book.id);

    if (!context.mounted) {
      return;
    }

    if (!deleted) {
      final error = ref.read(adminBookControllerProvider).error;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage(error))),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Book deleted.')),
    );
  }

  String _errorMessage(Object? error) {
    if (error is Failure) {
      return error.message;
    }

    return 'Something went wrong.';
  }
}

class BookFormDialog extends StatefulWidget {
  const BookFormDialog({
    this.book,
    super.key,
  });

  final Book? book;

  @override
  State<BookFormDialog> createState() {
    return _BookFormDialogState();
  }
}

class _BookFormDialogState extends State<BookFormDialog> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController authorController;
  late final TextEditingController isbnController;
  late final TextEditingController yearController;
  late final TextEditingController copiesController;

  @override
  void initState() {
    super.initState();

    final book = widget.book;

    titleController = TextEditingController(
      text: book?.title ?? '',
    );
    authorController = TextEditingController(
      text: book?.author ?? '',
    );
    isbnController = TextEditingController(
      text: book?.isbn ?? '',
    );
    yearController = TextEditingController(
      text: book?.publishedYear.toString() ?? '',
    );
    copiesController = TextEditingController(
      text: book?.totalCopies.toString() ?? '',
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    isbnController.dispose();
    yearController.dispose();
    copiesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.book != null;

    return AlertDialog(
      title: Text(
        isEditing ? 'Edit book' : 'Add book',
      ),
      content: SizedBox(
        width: 420,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: _requiredText,
                ),
                TextFormField(
                  controller: authorController,
                  decoration: const InputDecoration(
                    labelText: 'Author',
                  ),
                  validator: _requiredText,
                ),
                TextFormField(
                  controller: isbnController,
                  decoration: const InputDecoration(
                    labelText: 'ISBN',
                  ),
                  validator: _requiredText,
                ),
                TextFormField(
                  controller: yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Published year',
                  ),
                  validator: _positiveNumber,
                ),
                TextFormField(
                  controller: copiesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Total copies',
                  ),
                  validator: _positiveNumber,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(
            isEditing ? 'Save' : 'Add',
          ),
        ),
      ],
    );
  }

  String? _requiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    return null;
  }

  String? _positiveNumber(String? value) {
    final number = int.tryParse(value ?? '');

    if (number == null || number < 1) {
      return 'Enter a valid number.';
    }

    return null;
  }

  void _submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(
      context,
      BookFormData(
        title: titleController.text.trim(),
        author: authorController.text.trim(),
        isbn: isbnController.text.trim(),
        publishedYear: int.parse(yearController.text),
        totalCopies: int.parse(copiesController.text),
      ),
    );
  }
}

class BookFormData {
  const BookFormData({
    required this.title,
    required this.author,
    required this.isbn,
    required this.publishedYear,
    required this.totalCopies,
  });

  final String title;
  final String author;
  final String isbn;
  final int publishedYear;
  final int totalCopies;
}