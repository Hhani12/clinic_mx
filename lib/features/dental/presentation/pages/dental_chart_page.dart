import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils/date_formats.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_button.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/dental_plan_item.dart';
import '../../domain/entities/tooth_record.dart';
import '../../../doctors/presentation/providers/doctors_providers.dart';
import '../../../patients/domain/entities/patient.dart';
import '../../../patients/presentation/providers/patients_providers.dart';
import '../../../patients/presentation/widgets/investigation_section.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
import '../providers/dental_providers.dart';
import '../providers/tooth_records_providers.dart';
import '../widgets/teeth_chart.dart';
import '../widgets/tooth_detail_panel.dart';

class DentalChartPage extends ConsumerStatefulWidget {
  const DentalChartPage({super.key});

  @override
  ConsumerState<DentalChartPage> createState() => _DentalChartPageState();
}

class _DentalChartPageState extends ConsumerState<DentalChartPage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _customActionController = TextEditingController();
  final Set<int> _selectedTeeth = <int>{};

  int? _hoveredTooth;
  String? _selectedAction;
  String? _selectedDoctorId;
  bool _multiSelectEnabled = false;

  @override
  void dispose() {
    _noteController.dispose();
    _customActionController.dispose();
    super.dispose();
  }

  /// Save procedure: creates DentalPlanItem (audit log) AND updates ToothRecord
  Future<void> _applyAction({
    required String patientId,
    required String doctorId,
    required TeethNumberingSystem numberingSystem,
  }) async {
    final action = _selectedAction;
    if (action == null || _selectedTeeth.isEmpty) return;
    if (doctorId.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار طبيب')),
      );
      return;
    }

    // Find doctor name for tooth record
    final doctors = ref.read(activeDoctorsProvider);
    final doctorName = doctors
        .where((d) => d.id == doctorId)
        .map((d) => d.fullName)
        .firstOrNull;

    final toothIds = _selectedTeeth
        .map((universal) => numberingSystem == TeethNumberingSystem.fdi
            ? ToothMeta.of(universal).fdi
            : universal.toString())
        .toList();

    // 1. Save to dentalPlans (audit log — existing flow)
    await ref
        .read(dentalActionControllerProvider.notifier)
        .saveToTeeth(
          patientId: patientId,
          doctorId: doctorId,
          toothIds: toothIds,
          numberingSystem: numberingSystem.name,
          actionLabel: action,
          note: _noteController.text.trim(),
        );

    if (!mounted) return;
    final state = ref.read(dentalActionControllerProvider);
    if (state.hasError) return;

    // 2. Update tooth records (per-tooth state)
    for (final toothId in toothIds) {
      await ref
          .read(toothRecordControllerProvider.notifier)
          .addProcedure(
            patientId: patientId,
            toothId: toothId,
            actionLabel: action,
            doctorId: doctorId,
            doctorName: doctorName,
            note: _noteController.text.trim().isEmpty
                ? null
                : _noteController.text.trim(),
          );
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.tr('savedSuccessfully'))),
    );
    setState(() {
      _selectedTeeth.clear();
      _noteController.clear();
      _selectedAction = null;
      _multiSelectEnabled = false;
    });
  }

  void _showCustomActionDialog(List<String> existingActions) {
    _customActionController.clear();
    showDialog<void>(
      context: context,
      builder: (ctx) {
        final tr = ctx.l10n.tr;
        return AlertDialog(
          title: Text(tr('addCustomAction')),
          content: TextField(
            controller: _customActionController,
            decoration: InputDecoration(hintText: tr('actionName')),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(tr('cancel')),
            ),
            FilledButton(
              onPressed: () {
                final name = _customActionController.text.trim();
                if (name.isNotEmpty) {
                  setState(() => _selectedAction = name);
                }
                Navigator.pop(ctx);
              },
              child: Text(tr('save')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final patients =
        ref.watch(patientsStreamProvider).value ?? const <Patient>[];
    final doctors = ref.watch(activeDoctorsProvider);
    final selectedPatientId = ref.watch(selectedDentalPatientIdProvider);
    final numberingSystem = ref.watch(teethNumberingProvider);
    final actions = ref.watch(toothActionsProvider);
    final history = ref.watch(dentalItemsForSelectedPatientProvider);
    final editorState = ref.watch(dentalActionControllerProvider);
    final toothStatuses = ref.watch(toothStatusMapProvider);
    final procedureCounts = ref.watch(toothProcedureCountProvider);
    final toothRecords = ref.watch(toothRecordsForPatientProvider);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth >= 1100;
    final sidePanelWidth =
        (screenWidth * 0.3).clamp(320.0, 420.0).toDouble();
    final chartAreaWidth =
        (isDesktop ? screenWidth - sidePanelWidth - 80 : screenWidth - 32)
            .clamp(240.0, double.infinity)
            .toDouble();
    const selectorSpacing = 10.0;
    final selectorColumns = chartAreaWidth >= 900
        ? 3
        : chartAreaWidth >= 620
            ? 2
            : 1;
    final selectorWidth =
        ((chartAreaWidth - ((selectorColumns - 1) * selectorSpacing)) /
                selectorColumns)
            .clamp(220.0, chartAreaWidth)
            .toDouble();
    final tr = context.l10n.tr;

    ref.listen(dentalActionControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });
    ref.listen(toothRecordControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    if (patients.isNotEmpty && selectedPatientId == null) {
      Future.microtask(
        () => ref.read(selectedDentalPatientIdProvider.notifier).state =
            patients.first.id,
      );
    }
    if (doctors.isNotEmpty &&
        (_selectedDoctorId == null ||
            !doctors.any((item) => item.id == _selectedDoctorId))) {
      _selectedDoctorId = doctors.first.id;
    }

    // Get info for the first selected tooth
    ToothMeta? selectedToothMeta;
    ToothRecord? selectedToothRecord;
    if (_selectedTeeth.isNotEmpty) {
      selectedToothMeta = ToothMeta.of(_selectedTeeth.first);
      final records = toothRecords.valueOrNull ?? [];
      selectedToothRecord = records
          .where((r) => r.toothId == selectedToothMeta!.fdi)
          .firstOrNull;
    }

    return ClinicScaffold(
      title: tr('dentalChart'),
      selectedRoute: RoutePaths.dental,
      body: selectedPatientId == null
          ? Center(child: Text(tr('selectPatient')))
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main chart area
                Expanded(
                  child: ListView(
                    children: [
                      // Title
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Text(
                              tr('interactiveDentalChart'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '3D Interactive Dental Chart',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color:
                                        Colors.white.withValues(alpha: 0.6),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      // Patient + Doctor selectors
                      GlassCard(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              width: selectorWidth,
                              child: DropdownButtonFormField<String>(
                                key: ValueKey(
                                  'dental_patient_$selectedPatientId',
                                ),
                                initialValue: selectedPatientId,
                                items: patients
                                    .map((patient) => DropdownMenuItem(
                                          value: patient.id,
                                          child: Text(patient.displayName),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  ref
                                      .read(selectedDentalPatientIdProvider
                                          .notifier)
                                      .state = value;
                                },
                                decoration: InputDecoration(
                                  labelText: tr('selectPatient'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: selectorWidth,
                              child: DropdownButtonFormField<String>(
                                key: ValueKey(
                                  'dental_doctor_${_selectedDoctorId ?? 'none'}',
                                ),
                                initialValue: _selectedDoctorId,
                                items: doctors
                                    .map((doctor) => DropdownMenuItem(
                                          value: doctor.id,
                                          child: Text(doctor.fullName),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(
                                      () => _selectedDoctorId = value);
                                },
                                decoration: InputDecoration(
                                  labelText: tr('selectDoctor'),
                                ),
                              ),
                            ),
                            ChoiceChip(
                              label: Text(tr('multiSelectHint')),
                              selected: _multiSelectEnabled,
                              onSelected: (selected) {
                                setState(
                                    () => _multiSelectEnabled = selected);
                              },
                            ),
                            if (_selectedTeeth.isNotEmpty)
                              OutlinedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _selectedTeeth.clear();
                                    _multiSelectEnabled = false;
                                  });
                                },
                                icon: const Icon(Icons.clear_rounded),
                                label: Text(tr('clearSelection')),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Selection count bubble
                      if (_selectedTeeth.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child:
                              _SelectionBubble(count: _selectedTeeth.length),
                        ),
                      // The 3D-style teeth chart
                      GlassCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        child: TeethChart(
                          numberingSystem: numberingSystem,
                          selectedTeeth: _selectedTeeth,
                          hoveredTooth: _hoveredTooth,
                          toothStatuses: toothStatuses,
                          procedureCounts: procedureCounts,
                          onHover: (value) =>
                              setState(() => _hoveredTooth = value),
                          onTap: (tooth) {
                            setState(() {
                              if (_multiSelectEnabled) {
                                if (_selectedTeeth.contains(tooth)) {
                                  _selectedTeeth.remove(tooth);
                                } else {
                                  _selectedTeeth.add(tooth);
                                }
                              } else {
                                _selectedTeeth
                                  ..clear()
                                  ..add(tooth);
                              }
                            });
                            if (!isDesktop && !_multiSelectEnabled) {
                              _openMobileActionSheet(
                                patientId: selectedPatientId,
                                doctorId: _selectedDoctorId,
                                numberingSystem: numberingSystem,
                                actions: actions,
                                history: history,
                                editorState: editorState,
                              );
                            }
                          },
                          onLongPress: (tooth) {
                            setState(() {
                              _multiSelectEnabled = true;
                              if (_selectedTeeth.contains(tooth)) {
                                _selectedTeeth.remove(tooth);
                              } else {
                                _selectedTeeth.add(tooth);
                              }
                            });
                          },
                        ),
                      ),
                      // Tooth detail panel (shows procedures for selected tooth)
                      if (selectedToothMeta != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ToothDetailPanel(
                            toothMeta: selectedToothMeta,
                            patientId: selectedPatientId,
                            toothRecord: selectedToothRecord,
                          ),
                        ),
                      const SizedBox(height: 12),
                      InvestigationSection(patientId: selectedPatientId),
                      // On mobile show action panel inline
                      if (!isDesktop && _selectedTeeth.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        _DentalActionPanel(
                          selectedTeeth: _selectedTeeth,
                          selectedAction: _selectedAction,
                          noteController: _noteController,
                          actions: actions,
                          history: history,
                          editorState: editorState,
                          numberingSystem: numberingSystem,
                          onActionChanged: (v) =>
                              setState(() => _selectedAction = v),
                          onApply: () => _applyAction(
                            patientId: selectedPatientId,
                            doctorId: _selectedDoctorId ?? '',
                            numberingSystem: numberingSystem,
                          ),
                          onClearSelection: () =>
                              setState(() => _selectedTeeth.clear()),
                          onAddCustomAction: () =>
                              _showCustomActionDialog(actions),
                        ),
                      ],
                    ],
                  ),
                ),
                // Desktop right-side panel
                if (isDesktop) ...[
                  const SizedBox(width: 14),
                  SizedBox(
                    width: sidePanelWidth,
                    child: _DentalInfoPanel(
                      selectedToothMeta: selectedToothMeta,
                      selectedTeeth: _selectedTeeth,
                      selectedAction: _selectedAction,
                      noteController: _noteController,
                      actions: actions,
                      history: history,
                      editorState: editorState,
                      numberingSystem: numberingSystem,
                      onActionChanged: (v) =>
                          setState(() => _selectedAction = v),
                      onApply: () => _applyAction(
                        patientId: selectedPatientId,
                        doctorId: _selectedDoctorId ?? '',
                        numberingSystem: numberingSystem,
                      ),
                      onClearSelection: () =>
                          setState(() => _selectedTeeth.clear()),
                      onAddCustomAction: () =>
                          _showCustomActionDialog(actions),
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Future<void> _openMobileActionSheet({
    required String patientId,
    required String? doctorId,
    required TeethNumberingSystem numberingSystem,
    required List<String> actions,
    required AsyncValue<List<DentalPlanItem>> history,
    required AsyncValue<void> editorState,
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
        child: _DentalActionPanel(
          selectedTeeth: _selectedTeeth,
          selectedAction: _selectedAction,
          noteController: _noteController,
          actions: actions,
          history: history,
          editorState: editorState,
          numberingSystem: numberingSystem,
          onActionChanged: (v) => setState(() => _selectedAction = v),
          onApply: () {
            _applyAction(
              patientId: patientId,
              doctorId: doctorId ?? '',
              numberingSystem: numberingSystem,
            );
            Navigator.pop(context);
          },
          onClearSelection: () => setState(() => _selectedTeeth.clear()),
          onAddCustomAction: () => _showCustomActionDialog(actions),
        ),
      ),
    );
  }
}

class _SelectionBubble extends StatelessWidget {
  const _SelectionBubble({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.touch_app_rounded,
              size: 18,
              color: Color(0xFF00E5FF),
            ),
            const SizedBox(width: 8),
            Text(
              'تم تحديد $count أسنان',
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _DentalInfoPanel extends StatelessWidget {
  const _DentalInfoPanel({
    required this.selectedToothMeta,
    required this.selectedTeeth,
    required this.selectedAction,
    required this.noteController,
    required this.actions,
    required this.history,
    required this.editorState,
    required this.numberingSystem,
    required this.onActionChanged,
    required this.onApply,
    required this.onClearSelection,
    required this.onAddCustomAction,
  });

  final ToothMeta? selectedToothMeta;
  final Set<int> selectedTeeth;
  final String? selectedAction;
  final TextEditingController noteController;
  final List<String> actions;
  final AsyncValue<List<DentalPlanItem>> history;
  final AsyncValue<void> editorState;
  final TeethNumberingSystem numberingSystem;
  final ValueChanged<String?> onActionChanged;
  final VoidCallback onApply;
  final VoidCallback onClearSelection;
  final VoidCallback onAddCustomAction;

  @override
  Widget build(BuildContext context) {
    final tr = context.l10n.tr;
    final meta = selectedToothMeta;

    return GlassCard(
      child: ListView(
        shrinkWrap: false,
        children: [
          Text(
            tr('selectedToothInfo'),
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          if (meta != null) ...[
            _InfoRow(label: 'الاسم (بالعربية):', value: meta.nameAr),
            const SizedBox(height: 6),
            _InfoRow(
                label: 'الاسم الكلي (الإنجليزية):', value: meta.nameEn),
            const SizedBox(height: 14),
            Text(
              tr('numberingSystem'),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _NumberingChip(
                  label: 'نظام FDI',
                  isActive:
                      numberingSystem == TeethNumberingSystem.fdi,
                ),
                const SizedBox(width: 8),
                const Text('/',
                    style: TextStyle(color: Colors.white54)),
                const SizedBox(width: 8),
                _NumberingChip(
                  label: 'نظام يونيفرسال',
                  isActive:
                      numberingSystem == TeethNumberingSystem.universal,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                numberingSystem == TeethNumberingSystem.fdi
                    ? meta.fdi
                    : meta.universal.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ] else
            Text(
              tr('selectToothToView'),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white54),
            ),
          const SizedBox(height: 18),
          const Divider(height: 1),
          const SizedBox(height: 14),
          _DentalActionPanel(
            selectedTeeth: selectedTeeth,
            selectedAction: selectedAction,
            noteController: noteController,
            actions: actions,
            history: history,
            editorState: editorState,
            numberingSystem: numberingSystem,
            onActionChanged: onActionChanged,
            onApply: onApply,
            onClearSelection: onClearSelection,
            onAddCustomAction: onAddCustomAction,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _NumberingChip extends StatelessWidget {
  const _NumberingChip({required this.label, required this.isActive});
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF00E5FF).withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? const Color(0xFF00E5FF).withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.15),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
          color: isActive ? const Color(0xFF00E5FF) : Colors.white70,
        ),
      ),
    );
  }
}

class _DentalActionPanel extends StatelessWidget {
  const _DentalActionPanel({
    required this.selectedTeeth,
    required this.selectedAction,
    required this.noteController,
    required this.actions,
    required this.history,
    required this.editorState,
    required this.numberingSystem,
    required this.onActionChanged,
    required this.onApply,
    required this.onClearSelection,
    required this.onAddCustomAction,
  });

  final Set<int> selectedTeeth;
  final String? selectedAction;
  final TextEditingController noteController;
  final List<String> actions;
  final AsyncValue<List<DentalPlanItem>> history;
  final AsyncValue<void> editorState;
  final TeethNumberingSystem numberingSystem;
  final ValueChanged<String?> onActionChanged;
  final VoidCallback onApply;
  final VoidCallback onClearSelection;
  final VoidCallback onAddCustomAction;

  static const _actionIcons = <String, IconData>{
    'قلع': Icons.content_cut_rounded,
    'خلع': Icons.content_cut_rounded,
    'حشو': Icons.auto_fix_high_rounded,
    'حشوة': Icons.auto_fix_high_rounded,
    'تنظيف': Icons.cleaning_services_rounded,
    'عصب': Icons.cable_rounded,
    'علاج عصب': Icons.cable_rounded,
    'تقويم': Icons.grid_on_rounded,
    'تركيب': Icons.architecture_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final tr = context.l10n.tr;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          tr('dentalActions'),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...actions.map((action) {
              final isActive = selectedAction == action;
              return _ActionChip(
                label: action,
                icon: _actionIcons[action] ??
                    Icons.medical_services_rounded,
                isActive: isActive,
                onTap: () => onActionChanged(isActive ? null : action),
              );
            }),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onAddCustomAction,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(tr('addCustomAction')),
            style: OutlinedButton.styleFrom(
              side:
                  BorderSide(color: Colors.white.withValues(alpha: 0.2)),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          tr('doctorNotes'),
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: '...',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: GlassButton(
            label: '"${tr('save')}"',
            icon: Icons.arrow_forward_ios_rounded,
            expanded: true,
            onPressed: selectedTeeth.isEmpty ||
                    selectedAction == null ||
                    editorState.isLoading
                ? null
                : onApply,
          ),
        ),
        const SizedBox(height: 16),
        history.when(
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(error.toString()),
          data: (items) {
            if (items.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tr('dentalChart')} - ${tr('notes')}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 6),
                ...items.take(8).map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00E5FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${item.toothId} - ${item.actionLabel}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          DateFormats.dayMonthYear
                              .format(item.timestamp),
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF00E5FF).withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive
                  ? const Color(0xFF00E5FF).withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.15),
              width: isActive ? 1.5 : 1.0,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: const Color(0xFF00E5FF)
                          .withValues(alpha: 0.15),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive
                    ? const Color(0xFF00E5FF)
                    : Colors.white70,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive
                      ? const Color(0xFF00E5FF)
                      : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
