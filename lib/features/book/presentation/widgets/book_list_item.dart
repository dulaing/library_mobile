import 'package:flutter/material.dart';

import '../../domain/entities/book.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({required this.book, required this.onTap, super.key});

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isAvailable = book.availableCopies > 0;

    return ListTile(
      onTap: onTap,
      title: Text(book.title),
      subtitle: Text('${book.author}\nPublished ${book.publishedYear}'),
      isThreeLine: true,
      trailing: Text(
        isAvailable ? '${book.availableCopies} available' : 'Unavailable',
        style: TextStyle(
          color: isAvailable ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
