import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/theme/theme_controller.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/clinic_settings.dart';
import '../../domain/entities/staff_profile.dart';
import '../providers/settings_providers.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _addressController = TextEditingController();
  final _toothActionsController = TextEditingController();
  final _whatsAppSenderNumberController = TextEditingController();
  final _whatsAppPhoneNumberIdController = TextEditingController();

  bool _didPopulateClinic = false;
  bool _didPopulateSettings = false;
  Timer? _autoSaveTimer;

  int _columnsForWidth(double width) {
    if (width >= 980) return 3;
    if (width >= 640) return 2;
    return 1;
  }

  double _fieldWidth(double width, {int span = 1}) {
    const spacing = 10.0;
    final columns = _columnsForWidth(width);
    final normalizedSpan = span.clamp(1, columns);
    final columnWidth = (width - ((columns - 1) * spacing)) / columns;
    final totalWidth =
        (columnWidth * normalizedSpan) + ((normalizedSpan - 1) * spacing);
    return totalWidth.clamp(220.0, width).toDouble();
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _addressController.dispose();
    _toothActionsController.dispose();
    _whatsAppSenderNumberController.dispose();
    _whatsAppPhoneNumberIdController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer(const Duration(seconds: 3), () {
      _saveClinic();
    });
  }

  Future<void> _saveClinic() async {
    final clinicId = ref.read(currentClinicIdProvider);
    if (clinicId == null) return;
    await ref
        .read(settingsEditorControllerProvider.notifier)
        .saveClinic(
          clinicId: clinicId,
          name: _nameController.text,
          phone: _phoneController.text,
          city: _cityController.text,
          district: _districtController.text,
          address: _addressController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(currentUserRoleProvider);
    if (role == UserRole.reception) {
      return ClinicScaffold(
        title: context.l10n.tr('settings'),
        selectedRoute: RoutePaths.settings,
        body: Center(child: Text(context.l10n.tr('accessDenied'))),
      );
    }

    final clinicId = ref.watch(currentClinicIdProvider);
    final clinicAsync = ref.watch(clinicInfoProvider);
    final settingsAsync = ref.watch(clinicSettingsProvider);
    final usersAsync = ref.watch(clinicUsersProvider);
    final appearance = ref.watch(themeControllerProvider);
    final tr = context.l10n.tr;

    clinicAsync.whenData((clinic) {
      if (_didPopulateClinic || clinic == null) return;
      _didPopulateClinic = true;
      _nameController.text = clinic.name;
      _phoneController.text = clinic.phone ?? '';
      _cityController.text = clinic.city ?? '';
      _districtController.text = clinic.district ?? '';
      _addressController.text = clinic.address ?? '';
    });

    settingsAsync.whenData((settings) {
      if (_didPopulateSettings) return;
      _didPopulateSettings = true;
      _toothActionsController.text = settings.toothActions.join(', ');
      _whatsAppSenderNumberController.text =
          settings.whatsAppSenderNumber ?? '';
      _whatsAppPhoneNumberIdController.text =
          settings.whatsAppPhoneNumberId ?? '';
    });

    return ClinicScaffold(
      title: tr('settings'),
      selectedRoute: RoutePaths.settings,
      body: ListView(
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('clinicInfo'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final addressSpan = _columnsForWidth(width) == 1 ? 1 : 2;
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        SizedBox(
                          width: _fieldWidth(width),
                          child: TextField(
                            controller: _nameController,
                            onChanged: (_) => _onFieldChanged(),
                            decoration: InputDecoration(
                              labelText: tr('clinicName'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: _fieldWidth(width),
                          child: TextField(
                            controller: _phoneController,
                            onChanged: (_) => _onFieldChanged(),
                            decoration: InputDecoration(labelText: tr('phone')),
                          ),
                        ),
                        SizedBox(
                          width: _fieldWidth(width),
                          child: TextField(
                            controller: _cityController,
                            onChanged: (_) => _onFieldChanged(),
                            decoration: InputDecoration(labelText: tr('city')),
                          ),
                        ),
                        SizedBox(
                          width: _fieldWidth(width),
                          child: TextField(
                            controller: _districtController,
                            onChanged: (_) => _onFieldChanged(),
                            decoration: InputDecoration(
                              labelText: tr('district'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: _fieldWidth(width, span: addressSpan),
                          child: TextField(
                            controller: _addressController,
                            onChanged: (_) => _onFieldChanged(),
                            decoration: InputDecoration(
                              labelText: tr('clinicAddress'),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: clinicId == null ? null : _saveClinic,
                  child: Text(tr('save')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          settingsAsync.when(
            loading: () => Center(child: Text(tr('loading'))),
            error: (error, _) => Text(error.toString()),
            data: (settings) => _SettingsSection(
              clinicId: clinicId,
              settings: settings,
              toothActionsController: _toothActionsController,
              whatsAppSenderNumberController: _whatsAppSenderNumberController,
              whatsAppPhoneNumberIdController: _whatsAppPhoneNumberIdController,
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('configureTheme'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text(tr('lightTheme')),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text(tr('darkTheme')),
                      ),
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text(tr('systemTheme')),
                      ),
                    ],
                    selected: {appearance.themeMode},
                    onSelectionChanged: (selection) {
                      ref
                          .read(themeControllerProvider.notifier)
                          .setThemeMode(selection.first);
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${tr('blurIntensity')}: ${appearance.blurIntensity.toStringAsFixed(1)}',
                ),
                Slider(
                  min: 6,
                  max: 32,
                  divisions: 26,
                  value: appearance.blurIntensity,
                  onChanged: (value) {
                    ref
                        .read(themeControllerProvider.notifier)
                        .setBlurIntensity(value);
                  },
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text('${tr('language')}:'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SegmentedButton<String>(
                        segments: [
                          ButtonSegment(value: 'ar', label: Text(tr('arabic'))),
                          ButtonSegment(
                            value: 'en',
                            label: Text(tr('english')),
                          ),
                        ],
                        selected: {appearance.locale.languageCode},
                        onSelectionChanged: (selection) {
                          ref
                              .read(themeControllerProvider.notifier)
                              .setLocale(Locale(selection.first));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('userManagement'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                usersAsync.when(
                  loading: () => Text(tr('loading')),
                  error: (error, _) => Text(error.toString()),
                  data: (users) {
                    if (users.isEmpty) return Text(tr('noData'));
                    return Column(
                      children: users.map((user) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(user.displayName),
                          subtitle: Text(user.email),
                          trailing: DropdownButton<UserRole>(
                            value: user.role,
                            items: UserRole.values
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role.labelAr),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              ref
                                  .read(
                                    settingsEditorControllerProvider.notifier,
                                  )
                                  .updateRole(
                                    userId: user.uid,
                                    role: value.value,
                                  );
                            },
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _StaffManagementSection(clinicId: clinicId),
          const SizedBox(height: 12),
          _SubscriptionSection(clinicId: clinicId),
        ],
      ),
    );
  }
}

class _SubscriptionSection extends ConsumerWidget {
  const _SubscriptionSection({required this.clinicId});
  final String? clinicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (clinicId == null) return const SizedBox.shrink();
    final tr = context.l10n.tr;
    final clinicAsync = ref.watch(clinicInfoProvider);

    return clinicAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, _) => const SizedBox.shrink(),
      data: (clinic) {
        if (clinic == null) return const SizedBox.shrink();
        final isExpired = clinic.isExpired;
        final daysLeft = clinic.daysRemaining;
        final expiresAt = clinic.expiresAt;
        final userId = ref.read(currentUserIdProvider) ?? '';

        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    tr('subscriptionManagement'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isExpired
                          ? Colors.red.withValues(alpha: 0.15)
                          : Colors.green.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isExpired
                            ? Colors.red.withValues(alpha: 0.4)
                            : Colors.green.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      isExpired ? tr('clinicExpired') : tr('clinicActive'),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isExpired ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (expiresAt != null) ...[
                _SubscriptionRow(
                  label: tr('expiresOn'),
                  value:
                      '${expiresAt.year}-${expiresAt.month.toString().padLeft(2, '0')}-${expiresAt.day.toString().padLeft(2, '0')}',
                ),
                const SizedBox(height: 4),
                _SubscriptionRow(
                  label: tr('daysRemaining'),
                  value: isExpired ? '0' : '${daysLeft ?? 'N/A'}',
                ),
              ] else
                Text(
                  'لم يتم تعيين تاريخ انتهاء بعد',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              const SizedBox(height: 14),
              if (clinic.reactivationHistory.isNotEmpty) ...[
                Text(
                  'سجل إعادة التفعيل (${clinic.reactivationHistory.length})',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                ...clinic.reactivationHistory.reversed.take(3).map((r) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• ${r.reactivatedAt.year}-${r.reactivatedAt.month.toString().padLeft(2, '0')}-${r.reactivatedAt.day.toString().padLeft(2, '0')} → ينتهي ${r.newExpiresAt.year}-${r.newExpiresAt.month.toString().padLeft(2, '0')}-${r.newExpiresAt.day.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
              ],
              if (isExpired || expiresAt == null)
                FilledButton.icon(
                  onPressed: () {
                    _confirmReactivation(context, ref, clinicId!, userId);
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(tr('reactivate')),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _confirmReactivation(
    BuildContext context,
    WidgetRef ref,
    String clinicId,
    String userId,
  ) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إعادة تفعيل الاشتراك'),
        content: const Text(
          'سيتم تفعيل اشتراك العيادة لمدة سنة واحدة من الآن. هل تريد المتابعة؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.tr('cancel')),
          ),
          FilledButton(
            onPressed: () {
              ref
                  .read(settingsEditorControllerProvider.notifier)
                  .reactivateClinic(
                    clinicId: clinicId,
                    reactivatedBy: userId,
                  );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.tr('reactivateSuccess')),
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.green),
            child: Text(context.l10n.tr('reactivate')),
          ),
        ],
      ),
    );
  }
}

class _SubscriptionRow extends StatelessWidget {
  const _SubscriptionRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SettingsSection extends ConsumerWidget {
  const _SettingsSection({
    required this.clinicId,
    required this.settings,
    required this.toothActionsController,
    required this.whatsAppSenderNumberController,
    required this.whatsAppPhoneNumberIdController,
  });

  final String? clinicId;
  final ClinicSettings settings;
  final TextEditingController toothActionsController;
  final TextEditingController whatsAppSenderNumberController;
  final TextEditingController whatsAppPhoneNumberIdController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.l10n.tr;
    final whatsApp = ValueNotifier<bool>(settings.whatsAppEnabled);
    final sms = ValueNotifier<bool>(settings.smsEnabled);
    final email = ValueNotifier<bool>(settings.emailEnabled);
    final numbering = ValueNotifier<TeethNumberingSystem>(
      settings.teethNumberingSystem,
    );

    Future<void> persist() async {
      if (clinicId == null) return;
      await ref
          .read(settingsEditorControllerProvider.notifier)
          .saveClinicSettings(
            clinicId: clinicId!,
            settings: settings.copyWith(
              reminderOffsetHours: 24,
              whatsAppEnabled: whatsApp.value,
              whatsAppSenderNumber: whatsAppSenderNumberController.text.trim(),
              whatsAppPhoneNumberId: whatsAppPhoneNumberIdController.text
                  .trim(),
              smsEnabled: sms.value,
              emailEnabled: email.value,
              teethNumberingSystem: numbering.value,
              toothActions: toothActionsController.text
                  .split(',')
                  .map((value) => value.trim())
                  .where((value) => value.isNotEmpty)
                  .toList(),
            ),
          );
    }

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('reminderSettings'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            '${tr('reminderOffset')}: 24',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: whatsAppSenderNumberController,
            decoration: const InputDecoration(
              labelText: 'WhatsApp sender number (+964...)',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: whatsAppPhoneNumberIdController,
            decoration: const InputDecoration(
              labelText: 'WhatsApp phone number ID (Meta Cloud)',
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 10.0;
              final columns = constraints.maxWidth >= 900
                  ? 3
                  : constraints.maxWidth >= 560
                  ? 2
                  : 1;
              final tileWidth =
                  ((constraints.maxWidth - ((columns - 1) * spacing)) / columns)
                      .clamp(220.0, constraints.maxWidth)
                      .toDouble();
              return Wrap(
                spacing: spacing,
                runSpacing: 6,
                children: [
                  SizedBox(
                    width: tileWidth,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: whatsApp,
                      builder: (context, value, _) {
                        return SwitchListTile(
                          value: value,
                          onChanged: (updated) => whatsApp.value = updated,
                          title: Text(tr('whatsapp')),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: sms,
                      builder: (context, value, _) {
                        return SwitchListTile(
                          value: value,
                          onChanged: (updated) => sms.value = updated,
                          title: const Text('SMS'),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: email,
                      builder: (context, value, _) {
                        return SwitchListTile(
                          value: value,
                          onChanged: (updated) => email.value = updated,
                          title: const Text('Email'),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            'WhatsApp Business Cloud API credentials are server-side only (Cloud Functions config).',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<TeethNumberingSystem>(
            key: ValueKey('teeth_numbering_${numbering.value.name}'),
            initialValue: numbering.value,
            items: const [
              DropdownMenuItem(
                value: TeethNumberingSystem.fdi,
                child: Text('FDI'),
              ),
              DropdownMenuItem(
                value: TeethNumberingSystem.universal,
                child: Text('Universal'),
              ),
            ],
            onChanged: (value) {
              if (value != null) numbering.value = value;
            },
            decoration: InputDecoration(labelText: tr('dentalChart')),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: toothActionsController,
            decoration: InputDecoration(
              labelText: '${tr('dentalActions')} (comma separated)',
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(onPressed: persist, child: Text(tr('save'))),
        ],
      ),
    );
  }
}

class _StaffManagementSection extends ConsumerWidget {
  const _StaffManagementSection({required this.clinicId});
  final String? clinicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (clinicId == null) return const SizedBox.shrink();
    final tr = context.l10n.tr;
    final staffAsync = ref.watch(staffProfilesProvider);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tr('staffManagement')} (بروفايلات الفريق)',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton.filled(
                onPressed: () => _showAddStaffDialog(context, ref),
                icon: const Icon(Icons.person_add_rounded),
              ),
            ],
          ),
          const SizedBox(height: 10),
          staffAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text(e.toString()),
            data: (staff) {
              if (staff.isEmpty) {
                return Text(tr('noData'));
              }
              return Column(
                children: staff.map((p) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(p.name),
                    subtitle: Text(UserRoleX.fromString(p.role).labelAr),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (p.pin != null)
                          const Icon(Icons.lock_rounded, size: 16),
                        IconButton(
                          icon: const Icon(Icons.edit_rounded),
                          onPressed: () => _showAddStaffDialog(context, ref, p),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            ref
                                .read(settingsEditorControllerProvider.notifier)
                                .deleteStaffProfile(
                                  clinicId: clinicId!,
                                  profileId: p.id,
                                );
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddStaffDialog(
    BuildContext context,
    WidgetRef ref, [
    StaffProfile? existing,
  ]) {
    final nameController = TextEditingController(text: existing?.name);
    final pinController = TextEditingController(text: existing?.pin);
    UserRole selectedRole = UserRoleX.fromString(existing?.role);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existing == null ? 'إضافة موظف' : 'تعديل موظف'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'الاسم'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<UserRole>(
              value: selectedRole,
              items: UserRole.values
                  .map(
                    (r) => DropdownMenuItem(value: r, child: Text(r.labelAr)),
                  )
                  .toList(),
              onChanged: (v) => selectedRole = v!,
              decoration: const InputDecoration(labelText: 'الصلاحية'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pinController,
              decoration: const InputDecoration(
                labelText: 'الرمز السري (اختياري)',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final profile = StaffProfile(
                id:
                    existing?.id ??
                    DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                role: selectedRole.value,
                pin: pinController.text.isEmpty ? null : pinController.text,
              );
              ref
                  .read(settingsEditorControllerProvider.notifier)
                  .saveStaffProfile(clinicId: clinicId!, profile: profile);
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}
