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

  @override
  void dispose() {
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
      _whatsAppSenderNumberController.text = settings.whatsAppSenderNumber ?? '';
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
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SizedBox(
                      width: 280,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: tr('clinicName')),
                      ),
                    ),
                    SizedBox(
                      width: 260,
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: tr('phone')),
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: TextField(
                        controller: _cityController,
                        decoration: InputDecoration(labelText: tr('city')),
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: TextField(
                        controller: _districtController,
                        decoration: InputDecoration(labelText: tr('district')),
                      ),
                    ),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _addressController,
                        decoration: InputDecoration(labelText: tr('clinicAddress')),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: clinicId == null
                      ? null
                      : () => ref
                            .read(settingsEditorControllerProvider.notifier)
                            .saveClinic(
                              clinicId: clinicId,
                              name: _nameController.text,
                              phone: _phoneController.text,
                              city: _cityController.text,
                              district: _districtController.text,
                              address: _addressController.text,
                            ),
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
                SegmentedButton<ThemeMode>(
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
                const SizedBox(height: 12),
                Text('${tr('blurIntensity')}: ${appearance.blurIntensity.toStringAsFixed(1)}'),
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
                Row(
                  children: [
                    Text('${tr('language')}:'),
                    const SizedBox(width: 8),
                    SegmentedButton<String>(
                      segments: [
                        ButtonSegment(value: 'ar', label: Text(tr('arabic'))),
                        ButtonSegment(value: 'en', label: Text(tr('english'))),
                      ],
                      selected: {appearance.locale.languageCode},
                      onSelectionChanged: (selection) {
                        ref
                            .read(themeControllerProvider.notifier)
                            .setLocale(Locale(selection.first));
                      },
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
                                  .updateRole(userId: user.uid, role: value.value);
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
        ],
      ),
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
      await ref.read(settingsEditorControllerProvider.notifier).saveClinicSettings(
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
          Text(tr('reminderSettings'), style: Theme.of(context).textTheme.titleLarge),
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
          Row(
            children: [
              Expanded(
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
              Expanded(
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
              Expanded(
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
          FilledButton(
            onPressed: persist,
            child: Text(tr('save')),
          ),
        ],
      ),
    );
  }
}
