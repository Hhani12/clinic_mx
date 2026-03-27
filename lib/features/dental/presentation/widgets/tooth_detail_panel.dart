import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/date_formats.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/tooth_record.dart';
import '../providers/tooth_records_providers.dart';
import '../widgets/teeth_chart.dart';

class ToothDetailPanel extends ConsumerWidget {
  const ToothDetailPanel({
    super.key,
    required this.toothMeta,
    required this.patientId,
    required this.toothRecord,
  });

  final ToothMeta toothMeta;
  final String patientId;
  final ToothRecord? toothRecord;

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

  static const _statusColors = <String, Color>{
    'healthy': Color(0xFFE0E0E0),
    'filled': Color(0xFF4FC3F7),
    'extracted': Color(0xFFEF5350),
    'root_canal': Color(0xFFAB47BC),
    'crowned': Color(0xFFFFB74D),
    'braces': Color(0xFF7E57C2),
    'treated': Color(0xFF66BB6A),
    'decayed': Color(0xFFFF7043),
    'missing': Color(0xFF9E9E9E),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.l10n.tr;
    final record = toothRecord;
    final status = record?.status ?? 'healthy';
    final procedures = record?.procedures ?? [];
    final statusColor = _statusColors[status] ?? const Color(0xFFE0E0E0);
    final statusLabel = _statusLabels[status] ?? status;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tooth header
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.5),
                  ),
                ),
                child: Center(
                  child: Text(
                    '#${toothMeta.fdi}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toothMeta.nameAr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      toothMeta.nameEn,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Status chip
          Row(
            children: [
              Text(
                '${tr('status')}: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.4),
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
            ],
          ),
          const SizedBox(height: 14),

          // Procedure history
          Text(
            'سجل الإجراءات (${procedures.length})',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),

          if (procedures.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'لا توجد إجراءات مسجلة',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            )
          else
            ...procedures.reversed.map((proc) {
              return _ProcedureRow(
                procedure: proc,
                patientId: patientId,
                toothId: toothMeta.fdi,
              );
            }),

          // Notes
          if (record?.notes != null && record!.notes!.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.note_rounded,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    record.notes!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ProcedureRow extends ConsumerWidget {
  const _ProcedureRow({
    required this.procedure,
    required this.patientId,
    required this.toothId,
  });

  final ToothProcedure procedure;
  final String patientId;
  final String toothId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _actionColor(procedure.actionLabel),
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
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (procedure.doctorName != null)
                  Text(
                    procedure.doctorName!,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                if (procedure.note != null && procedure.note!.isNotEmpty)
                  Text(
                    procedure.note!,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Text(
            DateFormats.dayMonthYear.format(procedure.performedAt),
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 28,
            height: 28,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 14,
              icon: Icon(
                Icons.delete_outline_rounded,
                color: Colors.red.withValues(alpha: 0.7),
              ),
              onPressed: () {
                _confirmDelete(context, ref);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف الإجراء'),
        content: Text('هل تريد حذف "${procedure.actionLabel}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              ref
                  .read(toothRecordControllerProvider.notifier)
                  .deleteProcedure(
                    patientId: patientId,
                    toothId: toothId,
                    procedureId: procedure.id,
                  );
              Navigator.pop(ctx);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  Color _actionColor(String action) {
    const map = <String, Color>{
      'قلع': Color(0xFFEF5350),
      'خلع': Color(0xFFEF5350),
      'حشو': Color(0xFF4FC3F7),
      'حشوة': Color(0xFF4FC3F7),
      'تنظيف': Color(0xFF66BB6A),
      'عصب': Color(0xFFAB47BC),
      'علاج عصب': Color(0xFFAB47BC),
      'تقويم': Color(0xFF7E57C2),
      'تركيب': Color(0xFFFFB74D),
    };
    return map[action] ?? const Color(0xFF00E5FF);
  }
}
