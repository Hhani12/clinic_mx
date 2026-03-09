import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/widgets/glass_button.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/glass_text_field.dart';
import '../../../../core/widgets/liquid_background.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authControllerProvider.notifier).signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${context.l10n.tr('loginError')}: ${next.error}'),
          ),
        );
      }
    });

    return LiquidBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: GlassCard(
                  padding: const EdgeInsets.all(28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.tr('appName'),
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l10n.tr('login'),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        GlassTextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: context.l10n.tr('email'),
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.l10n.tr('requiredField');
                            }
                            if (!value.contains('@')) {
                              return context.l10n.tr('email');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        GlassTextField(
                          controller: _passwordController,
                          obscureText: true,
                          labelText: context.l10n.tr('password'),
                          prefixIcon: const Icon(Icons.lock_outline),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.l10n.tr('requiredField');
                            }
                            if (value.length < 6) {
                              return context.l10n.tr('password');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () => context.go(RoutePaths.forgotPassword),
                            child: Text(context.l10n.tr('forgotPassword')),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GlassButton(
                          label: context.l10n.tr('signIn'),
                          onPressed: authState.isLoading ? null : _submit,
                          expanded: true,
                          icon: Icons.login_rounded,
                        ),
                        if (!AppConfig.phoneAuthEnabled) ...[
                          const SizedBox(height: 16),
                          Text(
                            context.l10n.tr('phoneAuthDisabled'),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(context.l10n.tr('noAccount')),
                            TextButton(
                              onPressed: () => context.go(RoutePaths.register),
                              child: Text(context.l10n.tr('register')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
