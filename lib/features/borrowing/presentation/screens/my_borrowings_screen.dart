import 'package:flutter/material.dart';

class MyBorrowingsScreen extends StatelessWidget {
  const MyBorrowingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Borrowings'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Borrowing data is not connected yet.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}