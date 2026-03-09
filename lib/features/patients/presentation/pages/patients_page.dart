import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_button.dart';
import '../../../../core/widgets/glass_dialog.dart';
import '../../../../core/widgets/glass_search_bar.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/patient.dart';
import '../providers/patients_providers.dart';
import '../widgets/investigation_section.dart';
import '../widgets/patient_list_tile.dart';

class PatientsPage extends ConsumerWidget {
  const PatientsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientsStreamProvider);
    final filtered = ref.watch(filteredPatientsProvider);
    final clinicId = ref.watch(currentClinicIdProvider);

    return ClinicScaffold(
      title: context.l10n.tr('patients'),
      selectedRoute: RoutePaths.patients,
      floatingActionButton: GlassButton(
        label: context.l10n.tr('addPatient'),
        icon: Icons.person_add_alt_1_rounded,
        onPressed: () => context.go(RoutePaths.patientCreate),
      ),
      body: Column(
        children: [
          GlassSearchBar(
            hintText: context.l10n.tr('searchPatients'),
            onChanged: (value) =>
                ref.read(patientsSearchQueryProvider.notifier).state = value,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: patientsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text(error.toString())),
              data: (_) {
                if (filtered.isEmpty) {
                  return Center(child: Text(context.l10n.tr('noPatients')));
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final patient = filtered[index];
                    return PatientListTile(
                      patient: patient,
                      onAttachments: () =>
                          _openAttachmentsSheet(context, patient: patient),
                      onDelete: clinicId == null
                          ? null
                          : () =>
                                _deletePatient(context, ref, clinicId, patient),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openAttachmentsSheet(
    BuildContext context, {
    required Patient patient,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: Column(
            children: [
              Text(
                patient.displayName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Expanded(child: InvestigationSection(patientId: patient.id)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deletePatient(
    BuildContext context,
    WidgetRef ref,
    String clinicId,
    Patient patient,
  ) async {
    final confirm = await GlassDialog.show<bool>(
      context: context,
      icon: Icon(
        Icons.warning_amber_rounded,
        color: Theme.of(context).colorScheme.error,
      ),
      title: Text(context.l10n.tr('delete')),
      content: Text(patient.displayName),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(context.l10n.tr('cancel')),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(context.l10n.tr('delete')),
        ),
      ],
    );

    if (confirm != true || !context.mounted) return;
    await ref
        .read(patientFormControllerProvider.notifier)
        .delete(clinicId: clinicId, patientId: patient.id);
  }
}
