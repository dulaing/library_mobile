import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/presentation/screens/login_screen.dart';
import 'features/book/presentation/screens/books_screen.dart';

void main() {
  runApp(
      const ProviderScope(
          child: LibraryApp()
      )
  );
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  // A widget is simply a description of something Flutter should display

  @override
  Widget build(BuildContext context) {

    // use material design
    return MaterialApp(
      title: 'Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // use this color scheme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      // The first screen
      home: const LoginScreen(),
      //home: const BooksScreen(),
    );
  }
}
