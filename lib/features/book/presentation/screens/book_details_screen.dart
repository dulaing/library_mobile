import 'package:flutter/material.dart';

import '../../domain/entities/book.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final isAvailable = book.availableCopies > 0;

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
        ],
      ),
    );
  }
}
