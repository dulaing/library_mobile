import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:library_mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:library_mobile/features/auth/presentation/screens/login_screen.dart';

class TestAuthController extends AuthController {
  @override
  Future<AuthSession?> build() async {
    return null;
  }
}

void main() {
  testWidgets('app starts on the login screen', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(TestAuthController.new),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sign in to continue'), findsOneWidget);
  });
}
