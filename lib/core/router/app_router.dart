import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/book/presentation/providers/book_providers.dart';
import '../../features/book/presentation/screens/book_details_screen.dart';
import '../../features/book/presentation/screens/books_screen.dart';
import '../../features/borrowing/presentation/screens/my_borrowings_screen.dart';
import '../../features/member/presentation/screens/member_home_screen.dart';
import '../../features/member/presentation/screens/member_profile_screen.dart';
import 'app_route_names.dart';
import 'member_navigation_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final session = authState.asData?.value;
  final memberId = session?.memberId;

  final router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isMemberSignedIn = memberId != null;
      final isOnAuthScreen =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isMemberSignedIn && !isOnAuthScreen) {
        return '/login';
      }

      if (isMemberSignedIn && isOnAuthScreen) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          return memberId == null ? '/login' : '/home';
        },
      ),
      GoRoute(
        path: '/login',
        name: AppRouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: AppRouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MemberNavigationShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: AppRouteNames.home,
                builder: (context, state) => const MemberHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/books',
                name: AppRouteNames.books,
                builder: (context, state) => const BooksScreen(),
                routes: [
                  GoRoute(
                    path: ':bookId',
                    name: AppRouteNames.bookDetails,
                    builder: (context, state) {
                      final bookId = int.tryParse(
                        state.pathParameters['bookId'] ?? '',
                      );

                      return _BookDetailsRoute(bookId: bookId);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/borrowings',
                name: AppRouteNames.borrowings,
                builder: (context, state) {
                  return MyBorrowingsScreen(memberId: memberId);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: AppRouteNames.profile,
                builder: (context, state) => const MemberProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Page not found')),
        body: Center(child: Text(state.error.toString())),
      );
    },
  );

  ref.onDispose(router.dispose);
  return router;
});

class _BookDetailsRoute extends ConsumerWidget {
  const _BookDetailsRoute({required this.bookId});

  final int? bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = bookId;

    if (id == null) {
      return const _BookNotFoundScreen();
    }

    final bookResult = ref.watch(bookProvider(id));

    return bookResult.when(
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, stackTrace) {
        return const _BookNotFoundScreen();
      },
      data: (book) {
        return BookDetailsScreen(book: book);
      },
    );
  }
}

class _BookNotFoundScreen extends StatelessWidget {
  const _BookNotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Details')),
      body: const Center(child: Text('Book not found.')),
    );
  }
}
