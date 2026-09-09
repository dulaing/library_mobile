import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/presentation/screens/login_screen.dart';
import 'features/book/presentation/screens/books_screen.dart';
import 'core/theme/theme_mode_provider.dart';

void main() {
  runApp(
      const ProviderScope(
          child: LibraryApp()
      )
  );
}

class LibraryApp extends ConsumerWidget {
  const LibraryApp({super.key});

  // A widget is simply a description of something Flutter should display

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // LibraryApp must listen to Riverpod because the theme can change.
    final themeMode = ref.watch(themeModeControllerProvider);

    // use material design
    return MaterialApp(
      title: 'Library',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        // use this color scheme
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      // The first screen
      home: const LoginScreen(),
      //home: const BooksScreen(),
    );
  }
}
