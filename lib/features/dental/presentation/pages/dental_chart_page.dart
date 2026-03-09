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
import '../../../patients/domain/entities/patient.dart';
import '../../../patients/presentation/providers/patients_providers.dart';
import '../../../patients/presentation/widgets/investigation_section.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
import '../providers/dental_providers.dart';
import '../widgets/teeth_chart.dart';

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
  bool _multiSelectEnabled = false;

  @override
  void dispose() {
    _noteController.dispose();
    _customActionController.dispose();
    super.dispose();
  }

  Future<void> _applyAction({
    required String patientId,
    required TeethNumberingSystem numberingSystem,
  }) async {
    final action = _selectedAction;
    if (action == null || _selectedTeeth.isEmpty) return;

    final toothIds = _selectedTeeth
        .map(
          (universal) => numberingSystem == TeethNumberingSystem.fdi
              ? ToothMeta.of(universal).fdi
              : universal.toString(),
        )
        .toList();

    await ref
        .read(dentalActionControllerProvider.notifier)
        .saveToTeeth(
          patientId: patientId,
          toothIds: toothIds,
          numberingSystem: numberingSystem.name,
          actionLabel: action,
          note: _noteController.text.trim(),
        );

    if (!mounted) return;
    final state = ref.read(dentalActionControllerProvider);
    if (state.hasError) return;
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
    final selectedPatientId = ref.watch(selectedDentalPatientIdProvider);
    final numberingSystem = ref.watch(teethNumberingProvider);
    final actions = ref.watch(toothActionsProvider);
    final history = ref.watch(dentalItemsForSelectedPatientProvider);
    final editorState = ref.watch(dentalActionControllerProvider);
    final isDesktop = MediaQuery.sizeOf(context).width >= 1100;
    final tr = context.l10n.tr;

    ref.listen(dentalActionControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    if (patients.isNotEmpty && selectedPatientId == null) {
      Future.microtask(
        () => ref.read(selectedDentalPatientIdProvider.notifier).state =
            patients.first.id,
      );
    }

    // Get info for the first selected tooth (for the info panel)
    ToothMeta? selectedToothMeta;
    if (_selectedTeeth.isNotEmpty) {
      selectedToothMeta = ToothMeta.of(_selectedTeeth.first);
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
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Interactive Dental Chart',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.6),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      // Patient selector + controls
                      GlassCard(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              width: 280,
                              child: DropdownButtonFormField<String>(
                                key: ValueKey(
                                  'dental_patient_$selectedPatientId',
                                ),
                                initialValue: selectedPatientId,
                                items: patients
                                    .map(
                                      (patient) => DropdownMenuItem(
                                        value: patient.id,
                                        child: Text(patient.displayName),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  ref
                                          .read(
                                            selectedDentalPatientIdProvider
                                                .notifier,
                                          )
                                          .state =
                                      value;
                                },
                                decoration: InputDecoration(
                                  labelText: tr('selectPatient'),
                                ),
                              ),
                            ),
                            ChoiceChip(
                              label: Text(tr('multiSelectHint')),
                              selected: _multiSelectEnabled,
                              onSelected: (selected) {
                                setState(() => _multiSelectEnabled = selected);
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
                          child: _SelectionBubble(count: _selectedTeeth.length),
                        ),
                      // The teeth chart
                      GlassCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        child: TeethChart(
                          numberingSystem: numberingSystem,
                          selectedTeeth: _selectedTeeth,
                          hoveredTooth: _hoveredTooth,
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
                      // Info bubble for selected tooth
                      if (selectedToothMeta != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: _ToothInfoBubble(
                            meta: selectedToothMeta,
                            numberingSystem: numberingSystem,
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
                    width: 370,
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
                        numberingSystem: numberingSystem,
                      ),
                      onClearSelection: () =>
                          setState(() => _selectedTeeth.clear()),
                      onAddCustomAction: () => _showCustomActionDialog(actions),
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Future<void> _openMobileActionSheet({
    required String patientId,
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

/// Floating bubble showing "تم تحديد X أسنان"
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
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

/// Info bubble showing selected tooth details
class _ToothInfoBubble extends StatelessWidget {
  const _ToothInfoBubble({required this.meta, required this.numberingSystem});
  final ToothMeta meta;
  final TeethNumberingSystem numberingSystem;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF00E5FF).withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '#${numberingSystem == TeethNumberingSystem.fdi ? meta.fdi : meta.universal}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    color: Color(0xFF00E5FF),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  meta.nameAr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  '#${meta.fdi} FDI / #${meta.universal} Universal',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Desktop right-side information panel matching reference design
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
          // Tooth info section
          Text(
            tr('selectedToothInfo'),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          if (meta != null) ...[
            _InfoRow(label: 'الاسم (بالعربية):', value: meta.nameAr),
            const SizedBox(height: 6),
            _InfoRow(label: 'الاسم الكلي (الإنجليزية):', value: meta.nameEn),
            const SizedBox(height: 14),
            // Numbering system display
            Text(
              tr('numberingSystem'),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _NumberingChip(
                  label: 'نظام FDI',
                  isActive: numberingSystem == TeethNumberingSystem.fdi,
                ),
                const SizedBox(width: 8),
                const Text('/', style: TextStyle(color: Colors.white54)),
                const SizedBox(width: 8),
                _NumberingChip(
                  label: 'نظام يونيفرسال',
                  isActive: numberingSystem == TeethNumberingSystem.universal,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                numberingSystem == TeethNumberingSystem.fdi
                    ? meta.fdi
                    : meta.universal.toString(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ] else
            Text(
              tr('selectToothToView'),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white54),
            ),
          const SizedBox(height: 18),
          const Divider(height: 1),
          const SizedBox(height: 14),
          // Actions section
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
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
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

/// Action panel with procedure chips, notes, and save button
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
    'حشو': Icons.auto_fix_high_rounded,
    'تنظيف': Icons.cleaning_services_rounded,
    'عصب': Icons.cable_rounded,
    'تقويم': Icons.grid_on_rounded,
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
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        // Action chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...actions.map((action) {
              final isActive = selectedAction == action;
              return _ActionChip(
                label: action,
                icon: _actionIcons[action] ?? Icons.medical_services_rounded,
                isActive: isActive,
                onTap: () => onActionChanged(isActive ? null : action),
              );
            }),
          ],
        ),
        const SizedBox(height: 8),
        // Add custom action button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onAddCustomAction,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(tr('addCustomAction')),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Doctor notes
        Text(
          tr('doctorNotes'),
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: '...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        const SizedBox(height: 16),
        // Save button
        SizedBox(
          width: double.infinity,
          child: GlassButton(
            label: '"${tr('save')}"',
            icon: Icons.arrow_forward_ios_rounded,
            expanded: true,
            onPressed:
                selectedTeeth.isEmpty ||
                    selectedAction == null ||
                    editorState.isLoading
                ? null
                : onApply,
          ),
        ),
        // History
        const SizedBox(height: 16),
        history.when(
          loading: () => const Center(child: CircularProgressIndicator()),
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
                ...items.take(6).map((item) {
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
                          DateFormats.dayMonthYear.format(item.timestamp),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.5),
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                      color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
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
                color: isActive ? const Color(0xFF00E5FF) : Colors.white70,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? const Color(0xFF00E5FF) : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
