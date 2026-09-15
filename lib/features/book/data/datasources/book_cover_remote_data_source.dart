import 'package:dio/dio.dart';

// The library API has no book images, so covers are looked up on Open Library by title.
class BookCoverRemoteDataSource {
  BookCoverRemoteDataSource(this.dio);

  final Dio dio;

  static String coverUrl(int coverId, {bool large = false}) {
    final size = large ? 'L' : 'M';

    return 'https://covers.openlibrary.org/b/id/$coverId-$size.jpg';
  }

  Future<int?> findCoverId({required String title, String? author}) async {
    final coverId = await searchCoverId(title: title, author: author);

    if (coverId != null || author == null) {
      return coverId;
    }

    // The author name in the library may be spelled differently, so retry with the title only.
    return searchCoverId(title: title);
  }

  Future<int?> searchCoverId({required String title, String? author}) async {
    try {
      final response = await dio.get(
        '/search.json',
        queryParameters: {
          'title': title,
          'author': ?author,
          'fields': 'cover_i',
          'limit': 5,
        },
      );

      final data = response.data;
      final docs = data is Map ? data['docs'] : null;

      if (docs is! List) {
        return null;
      }

      for (final doc in docs) {
        if (doc is Map && doc['cover_i'] is int) {
          return doc['cover_i'] as int;
        }
      }

      return null;
    } on DioException {
      return null;
    }
  }
}
