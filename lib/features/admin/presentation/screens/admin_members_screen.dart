import 'package:flutter/material.dart';

class AdminMembersScreen extends StatelessWidget {
  const AdminMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Members')),
      body: const Center(child: Text('Admin member tools will go here.')),
    );
  }
}
