import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_provider.dart';

void main() {
  runApp(const ProviderScope(child: LibraryApp()));
}

class LibraryApp extends ConsumerWidget {
  const LibraryApp({super.key});

  // A widget is simply a description of something Flutter should display

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // LibraryApp must listen to Riverpod because the theme can change.
    final themeMode = ref.watch(themeModeControllerProvider);
    final router = ref.watch(appRouterProvider);

    // use material design
    return MaterialApp.router(
      title: 'Library',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: router,
    );
  }
}
