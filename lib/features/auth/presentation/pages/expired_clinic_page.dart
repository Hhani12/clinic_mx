import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/glass_button.dart';
import '../../../../core/widgets/glass_card.dart';
import '../controllers/auth_controller.dart';

class ExpiredClinicPage extends ConsumerWidget {
  const ExpiredClinicPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.l10n.tr;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: GlassCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.timer_off_rounded,
                      size: 36,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'انتهت صلاحية الاشتراك',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'انتهت فترة اشتراك العيادة. يرجى التواصل مع المسؤول لإعادة تفعيل الحساب.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  GlassButton(
                    label: tr('signOut'),
                    icon: Icons.logout_rounded,
                    expanded: true,
                    onPressed: () {
                      ref.read(authControllerProvider.notifier).signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
