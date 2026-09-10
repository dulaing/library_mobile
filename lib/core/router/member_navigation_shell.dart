import 'package:flutter/material.dart';

import '../../features/member/presentation/screens/member_home_screen.dart';
import '../../features/book/presentation/screens/books_screen.dart';
import '../../features/borrowing/presentation/screens/my_borrowings_screen.dart';
import '../../features/member/presentation/screens/member_profile_screen.dart';

class MemberNavigationShell extends StatefulWidget {
  const MemberNavigationShell({
    required this.memberId,
    super.key,
  });

  final int memberId;

  @override
  State<MemberNavigationShell> createState() {
    return _MemberNavigationShellState();
  }
}

class _MemberNavigationShellState extends State<MemberNavigationShell> {
  int selectedIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          const MemberHomeScreen(),
          const BooksScreen(),
          MyBorrowingsScreen(
            memberId: widget.memberId,
          ),
          const MemberProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: selectPage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Books',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Borrowings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}