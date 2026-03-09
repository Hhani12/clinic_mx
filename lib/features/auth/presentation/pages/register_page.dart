import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/widgets/glass_button.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/glass_text_field.dart';
import '../../../../core/widgets/liquid_background.dart';
import '../controllers/auth_controller.dart';
import '../../domain/entities/app_user_profile.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _clinicIdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _clinicIdController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final profile = AppUserProfile(
      uid: '',
      clinicId: _clinicIdController.text.trim(),
      email: _emailController.text.trim(),
      displayName: _nameController.text.trim(),
      role: UserRole.admin,
      isActive: true,
    );

    await ref.read(authControllerProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          profile: profile,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${context.l10n.tr('error')}: ${next.error}')),
        );
      }
    });

    return LiquidBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(RoutePaths.login),
          ),
        ),
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
                          context.l10n.tr('register'),
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        GlassTextField(
                          controller: _nameController,
                          labelText: context.l10n.tr('displayName'),
                          prefixIcon: const Icon(Icons.person_outline),
                          validator: (value) => (value == null || value.isEmpty)
                              ? context.l10n.tr('requiredField')
                              : null,
                        ),
                        const SizedBox(height: 14),
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
                          controller: _clinicIdController,
                          labelText: context.l10n.tr('clinicId'),
                          prefixIcon: const Icon(Icons.business_outlined),
                          validator: (value) => (value == null || value.isEmpty)
                              ? context.l10n.tr('requiredField')
                              : null,
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
                        const SizedBox(height: 24),
                        GlassButton(
                          label: context.l10n.tr('register'),
                          onPressed: authState.isLoading ? null : _submit,
                          expanded: true,
                          icon: Icons.person_add_rounded,
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
