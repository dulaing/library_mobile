import '../models/book_model.dart';

abstract class BookLocalDataSource {
  Future<List<BookModel>> getBooks();
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  @override
  Future<List<BookModel>> getBooks() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    final List<Map<String, dynamic>> records = [
      {
        'id': 1,
        'title': 'Clean Code',
        'author': 'Robert C. Martin',
        'isbn': '9780132350884',
        'publishedYear': 2008,
        'totalCopies': 7,
        'availableCopies': 4,
      },
      {
        'id': 2,
        'title': 'The Pragmatic Programmer',
        'author': 'David Thomas and Andrew Hunt',
        'isbn': '9780135957059',
        'publishedYear': 2019,
        'totalCopies': 3,
        'availableCopies': 0,
      },
    ];

    return records
        .map((record) => BookModel.fromJson(record))
        .toList();
  }
}