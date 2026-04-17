import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_formats.dart';
import '../../../../core/widgets/glass_button.dart';
import '../../../doctors/domain/entities/doctor_profile.dart';
import '../../domain/entities/tooth_record.dart';
import 'teeth_chart.dart';

typedef ProcedureApplyCallback = void Function({
  required String action,
  required String doctorId,
  required String note,
});

class ToothProcedureSheet extends ConsumerStatefulWidget {
  const ToothProcedureSheet({
    super.key,
    required this.universal,
    required this.patientId,
    required this.toothRecord,
    required this.doctors,
    required this.extraActions,
    required this.onApply,
    this.initialDoctorId,
  });

  final int universal;
  final String patientId;
  final ToothRecord? toothRecord;
  final List<DoctorProfile> doctors;
  final List<String> extraActions; // custom actions from settings
  final ProcedureApplyCallback onApply;
  final String? initialDoctorId;

  @override
  ConsumerState<ToothProcedureSheet> createState() =>
      _ToothProcedureSheetState();
}

class _ToothProcedureSheetState extends ConsumerState<ToothProcedureSheet> {
  String? _selectedAction;
  String? _selectedDoctorId;
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _customController = TextEditingController();
  bool _isSaving = false;

  static const _builtinChips = <(String, Color, IconData)>[
    ('حشوة', Color(0xFF4FC3F7), Icons.auto_fix_high_rounded),
    ('تنظيف', Color(0xFF66BB6A), Icons.cleaning_services_rounded),
    ('علاج عصب', Color(0xFFAB47BC), Icons.cable_rounded),
    ('قلع', Color(0xFFEF5350), Icons.content_cut_rounded),
    ('تركيب', Color(0xFFFFB74D), Icons.architecture_rounded),
    ('تقويم', Color(0xFF7E57C2), Icons.grid_on_rounded),
    ('مسوس', Color(0xFFFF7043), Icons.warning_amber_rounded),
  ];

  static const _statusColors = <String, Color>{
    'healthy': Color(0xFFE8E4DC),
    'filled': Color(0xFF4FC3F7),
    'extracted': Color(0xFFEF5350),
    'root_canal': Color(0xFFAB47BC),
    'crowned': Color(0xFFFFB74D),
    'braces': Color(0xFF7E57C2),
    'treated': Color(0xFF66BB6A),
    'decayed': Color(0xFFFF7043),
    'missing': Color(0xFF9E9E9E),
  };

  static const _statusLabels = <String, String>{
    'healthy': 'سليم',
    'filled': 'محشو',
    'extracted': 'مخلوع',
    'root_canal': 'علاج عصب',
    'crowned': 'تركيبة',
    'braces': 'تقويم',
    'treated': 'معالج',
    'decayed': 'مسوس',
    'missing': 'مفقود',
  };

  @override
  void initState() {
    super.initState();
    _selectedDoctorId = widget.initialDoctorId ??
        (widget.doctors.isNotEmpty ? widget.doctors.first.id : null);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _customController.dispose();
    super.dispose();
  }

  Future<void> _handleApply() async {
    final action = _selectedAction;
    final doctorId = _selectedDoctorId;
    if (action == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار إجراء')),
      );
      return;
    }
    if (doctorId == null || doctorId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار طبيب')),
      );
      return;
    }
    setState(() => _isSaving = true);
    widget.onApply(
      action: action,
      doctorId: doctorId,
      note: _noteController.text.trim(),
    );
    if (mounted) Navigator.of(context).pop();
  }

  void _showCustomDialog() {
    _customController.clear();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إجراء مخصص'),
        content: TextField(
          controller: _customController,
          decoration: const InputDecoration(hintText: 'اسم الإجراء'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final name = _customController.text.trim();
              if (name.isNotEmpty) setState(() => _selectedAction = name);
              Navigator.pop(ctx);
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final meta = ToothMeta.of(widget.universal);
    final record = widget.toothRecord;
    final status = record?.status ?? 'healthy';
    final statusColor = _statusColors[status] ?? const Color(0xFFE8E4DC);
    final statusLabel = _statusLabels[status] ?? status;
    final procedures = record?.procedures ?? [];

    // Build all chips: builtin + extra actions from settings (excluding duplicates)
    final builtinLabels = _builtinChips.map((c) => c.$1).toSet();
    final extraUniq = widget.extraActions
        .where((a) => !builtinLabels.contains(a))
        .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.45,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
          child: Column(
            children: [
              // Drag handle
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 14),

              // Tooth preview header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 3D tooth preview
                    Container(
                      width: 64,
                      height: 90,
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.25),
                        ),
                      ),
                      child: CustomPaint(
                        painter: BuccalTooth3DPainter(
                          shape: meta.shape,
                          isUpper: meta.isUpperJaw,
                          isSelected: false,
                          isHovered: false,
                          accentColor: statusColor,
                          status: status,
                          statusColor: statusColor,
                          isExtracted: status == 'extracted' ||
                              status == 'missing',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meta.nameAr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            meta.nameEn,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.55),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: statusColor.withValues(alpha: 0.40),
                                  ),
                                ),
                                child: Text(
                                  statusLabel,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.07),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'FDI ${meta.fdi}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white.withValues(alpha: 0.55),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Divider(
                  height: 1, color: Colors.white.withValues(alpha: 0.10)),

              // Scrollable body
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  children: [
                    // Procedure chips section
                    _SectionLabel('الإجراء'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        // Built-in chips
                        ..._builtinChips.map((chip) {
                          final isActive = _selectedAction == chip.$1;
                          return _ProcedureChip(
                            label: chip.$1,
                            color: chip.$2,
                            icon: chip.$3,
                            isActive: isActive,
                            onTap: () => setState(() =>
                                _selectedAction = isActive ? null : chip.$1),
                          );
                        }),
                        // Extra custom actions from settings
                        ...extraUniq.map((action) {
                          final isActive = _selectedAction == action;
                          return _ProcedureChip(
                            label: action,
                            color: const Color(0xFF00E5FF),
                            icon: Icons.medical_services_rounded,
                            isActive: isActive,
                            onTap: () => setState(() =>
                                _selectedAction = isActive ? null : action),
                          );
                        }),
                        // Custom action button
                        _ProcedureChip(
                          label: '+ مخصص',
                          color: Colors.white54,
                          icon: Icons.add_rounded,
                          isActive: false,
                          onTap: _showCustomDialog,
                        ),
                      ],
                    ),

                    // Show selected custom action if any
                    if (_selectedAction != null &&
                        !_builtinChips
                            .any((c) => c.$1 == _selectedAction) &&
                        !extraUniq.contains(_selectedAction)) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF00E5FF).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF00E5FF)
                                .withValues(alpha: 0.35),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle_rounded,
                                size: 14, color: Color(0xFF00E5FF)),
                            const SizedBox(width: 6),
                            Text(
                              _selectedAction!,
                              style: const TextStyle(
                                color: Color(0xFF00E5FF),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 18),

                    // Doctor selection
                    _SectionLabel('الطبيب'),
                    const SizedBox(height: 8),
                    if (widget.doctors.isEmpty)
                      Text('لا يوجد أطباء',
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5)))
                    else
                      DropdownButtonFormField<String>(
                        initialValue: _selectedDoctorId,
                        items: widget.doctors
                            .map((d) => DropdownMenuItem(
                                  value: d.id,
                                  child: Text(d.fullName),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedDoctorId = v),
                        decoration: const InputDecoration(
                          labelText: 'اختر الطبيب',
                          border: OutlineInputBorder(),
                        ),
                      ),

                    const SizedBox(height: 18),

                    // Notes field
                    _SectionLabel('ملاحظات'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _noteController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'ملاحظات إضافية...',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Apply button
                    GlassButton(
                      label: 'تطبيق الإجراء',
                      icon: Icons.check_rounded,
                      expanded: true,
                      onPressed: _isSaving ? null : _handleApply,
                    ),

                    // Procedure history
                    if (procedures.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Divider(
                          height: 1,
                          color: Colors.white.withValues(alpha: 0.10)),
                      const SizedBox(height: 12),
                      _SectionLabel('سجل الإجراءات (${procedures.length})'),
                      const SizedBox(height: 8),
                      ...procedures.reversed.map((proc) =>
                          _CompactProcedureRow(procedure: proc)),
                    ],

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Section label helper
// ---------------------------------------------------------------------------
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Colors.white.withValues(alpha: 0.85),
        letterSpacing: 0.3,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Procedure chip
// ---------------------------------------------------------------------------
class _ProcedureChip extends StatelessWidget {
  const _ProcedureChip({
    required this.label,
    required this.color,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final Color color;
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
          duration: const Duration(milliseconds: 160),
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? color.withValues(alpha: 0.22)
                : Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive
                  ? color.withValues(alpha: 0.65)
                  : Colors.white.withValues(alpha: 0.14),
              width: isActive ? 1.5 : 1.0,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.20),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: 15,
                  color: isActive ? color : Colors.white60),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? color : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Compact (read-only) procedure history row in sheet
// ---------------------------------------------------------------------------
class _CompactProcedureRow extends StatelessWidget {
  const _CompactProcedureRow({required this.procedure});
  final ToothProcedure procedure;

  static const _actionColors = <String, Color>{
    'قلع': Color(0xFFEF5350),
    'خلع': Color(0xFFEF5350),
    'حشو': Color(0xFF4FC3F7),
    'حشوة': Color(0xFF4FC3F7),
    'تنظيف': Color(0xFF66BB6A),
    'عصب': Color(0xFFAB47BC),
    'علاج عصب': Color(0xFFAB47BC),
    'تقويم': Color(0xFF7E57C2),
    'تركيب': Color(0xFFFFB74D),
    'مسوس': Color(0xFFFF7043),
  };

  @override
  Widget build(BuildContext context) {
    final dot = _actionColors[procedure.actionLabel] ?? const Color(0xFF00E5FF);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  procedure.actionLabel,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
                if (procedure.doctorName != null)
                  Text(
                    procedure.doctorName!,
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withValues(alpha: 0.5)),
                  ),
              ],
            ),
          ),
          Text(
            DateFormats.dayMonthYear.format(procedure.performedAt),
            style: TextStyle(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.45)),
          ),
        ],
      ),
    );
  }
}
