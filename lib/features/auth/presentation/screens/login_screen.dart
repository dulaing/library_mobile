import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/widgets/hero_card.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    final formIsValid = formKey.currentState!.validate();

    if (!formIsValid) {
      return;
    }

    await ref
        .read(authControllerProvider.notifier)
        .signIn(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    final authError = authState.error;

    final errorMessage = authError is Failure ? authError.message : null;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final headerIsDark =
        ThemeData.estimateBrightnessForColor(colors.primary) ==
        Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: headerIsDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: colors.primary,
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _LoginHeader()),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(28, 36, 28, 16),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(36),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Login',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: colors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Sign in to continue',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 32),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.mail_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Enter your email.';
                                }

                                if (!value.contains('@')) {
                                  return 'Enter a valid email.';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: passwordController,
                              obscureText: hidePassword,
                              onFieldSubmitted: (_) {
                                if (!authState.isLoading) {
                                  signIn();
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: Icon(
                                    hidePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your password.';
                                }

                                return null;
                              },
                            ),
                            if (errorMessage != null) ...[
                              const SizedBox(height: 16),
                              _ErrorBanner(message: errorMessage),
                            ],
                            const SizedBox(height: 28),
                            FilledButton(
                              onPressed: authState.isLoading ? null : signIn,
                              child: authState.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text('Sign in'),
                            ),
                            const SizedBox(height: 24),
                            const Spacer(),
                            Text(
                              'Accounts are created by the library staff.',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(top: -88, right: 36, child: _BookStack()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Stack(
      children: [
        Positioned(
          top: -80,
          left: -60,
          child: DecorativeCircle(
            size: 220,
            color: colors.onPrimary.withValues(alpha: 0.08),
          ),
        ),
        Positioned(
          top: 70,
          left: 120,
          child: DecorativeCircle(
            size: 48,
            color: colors.onPrimary.withValues(alpha: 0.07),
          ),
        ),
        Positioned(
          top: 30,
          right: -40,
          child: DecorativeCircle(
            size: 130,
            color: colors.onPrimary.withValues(alpha: 0.05),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 72, 28, 72),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello!',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Welcome to the Library',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Books resting on the edge of the form sheet.
class _BookStack extends StatelessWidget {
  const _BookStack();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _BookSpine(width: 22, height: 70, color: colors.primaryContainer),
        const SizedBox(width: 3),
        _BookSpine(width: 30, height: 90, color: colors.onPrimary),
        const SizedBox(width: 3),
        Transform.rotate(
          angle: 0.2,
          alignment: Alignment.bottomLeft,
          child: _BookSpine(
            width: 20,
            height: 76,
            color: Color.lerp(colors.primary, colors.onPrimary, 0.55)!,
          ),
        ),
      ],
    );
  }
}

class _BookSpine extends StatelessWidget {
  const _BookSpine({
    required this.width,
    required this.height,
    required this.color,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bandColor = Colors.black.withValues(alpha: 0.12);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            color: bandColor,
          ),
          const SizedBox(height: 6),
          Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            color: bandColor,
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 20, color: colors.onErrorContainer),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: colors.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}
