import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../core/utils/date_formats.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../patients/domain/entities/patient.dart';
import '../../../patients/presentation/providers/patients_providers.dart';
import '../../../doctors/domain/entities/doctor_profile.dart';
import '../../../doctors/presentation/providers/doctors_providers.dart';
import '../../../../core/services/printing_service.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
import '../../domain/entities/payment_transaction.dart';
import '../providers/payments_providers.dart';

class PaymentsPage extends ConsumerWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(filteredPaymentsProvider);
    final stats = ref.watch(auditStatsProvider);
    final clinicId = ref.watch(currentClinicIdProvider);
    final clinicInfo = ref.watch(clinicInfoProvider).valueOrNull;
    final range = ref.watch(auditDateRangeProvider);
    final selectedDoctorId = ref.watch(selectedAuditDoctorIdProvider);
    final doctors = ref.watch(activeDoctorsProvider);
    final tr = context.l10n.tr;

    final selectedDoctor = selectedDoctorId != null
        ? doctors.firstWhere((d) => d.id == selectedDoctorId)
        : null;

    return ClinicScaffold(
      title: tr('payments'),
      selectedRoute: RoutePaths.payments,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openPaymentSheet(context),
        icon: const Icon(Icons.add_rounded),
        label: Text(tr('addPayment')),
      ),
      body: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 10.0;
              final columns = constraints.maxWidth >= 1024
                  ? 4
                  : constraints.maxWidth >= 680
                      ? 2
                      : 1;
              final cardWidth =
                  ((constraints.maxWidth - ((columns - 1) * spacing)) / columns)
                      .clamp(160.0, constraints.maxWidth)
                      .toDouble();
              return Column(
                children: [
                  _DateRangeFilterBar(
                    onPrint: () {
                      final payments = ref.read(filteredPaymentsProvider).valueOrNull ?? [];
                      PrintingService.printAuditReport(
                        clinic: clinicInfo,
                        range: range,
                        doctorName: selectedDoctor?.fullName,
                        stats: stats,
                        transactions: payments,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      _TotalCard(
                        width: cardWidth,
                        title: 'الواصل (من المرضى)',
                        value: stats['collected'] ?? 0,
                        color: Colors.green,
                      ),
                      _TotalCard(
                        width: cardWidth,
                        title: 'المتبقي (على المرضى)',
                        value: stats['pending'] ?? 0,
                        color: Colors.orange,
                      ),
                      _TotalCard(
                        width: cardWidth,
                        title: 'للأطباء (واصل)',
                        value: stats['doctorsShare'] ?? 0,
                        color: Colors.blue,
                      ),
                      _TotalCard(
                        width: cardWidth,
                        title: 'صافي العيادة',
                        value: stats['clinicNet'] ?? 0,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchBar(
              hintText: 'البحث في المدفوعات (اسم المريض، الطبيب، ملاحظات)',
              leading: const Icon(Icons.search_rounded),
              onChanged: (value) {
                ref.read(paymentSearchQueryProvider.notifier).state = value;
              },
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: paymentsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text(error.toString())),
              data: (payments) {
                if (payments.isEmpty) {
                  return Center(child: Text(tr('noData')));
                }
                return ListView.builder(
                  itemCount: payments.length,
                  itemBuilder: (context, index) {
                    final payment = payments[index];
                    return GlassCard(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  payment.patientName,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${tr('amount')}: ${CurrencyFormat.iqd(payment.amount)}'
                                  ' | ${tr('paid')}: ${CurrencyFormat.iqd(payment.paid)}'
                                  ' | ${tr('remaining')}: ${CurrencyFormat.iqd(payment.remaining)}',
                                ),
                                if (payment.doctorName != null)
                                  Text(
                                    '${tr('doctor')}: ${payment.doctorName} (حصة: ${CurrencyFormat.iqd(payment.doctorShare)})',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                Text(
                                  DateFormats.dayMonthYear.format(payment.date),
                                ),
                                if (payment.notes != null)
                                  Text(
                                    'ملاحظات: ${payment.notes}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white70,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: clinicId == null
                                ? null
                                : () => ref
                                      .read(
                                        paymentEditorControllerProvider
                                            .notifier,
                                      )
                                      .delete(
                                        clinicId: clinicId,
                                        paymentId: payment.id,
                                      ),
                            icon: const Icon(Icons.delete_outline_rounded),
                          ),
                        ],
                      ),
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

  Future<void> _openPaymentSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _PaymentFormSheet(),
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({
    required this.width,
    required this.title,
    required this.value,
    this.color,
  });

  final double width;
  final String title;
  final double value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                CurrencyFormat.iqd(value),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: color,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateRangeFilterBar extends ConsumerWidget {
  const _DateRangeFilterBar({required this.onPrint});

  final VoidCallback onPrint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(auditDateRangeProvider);
    final selectedDoctorId = ref.watch(selectedAuditDoctorIdProvider);
    final doctors = ref.watch(activeDoctorsProvider);

    void updateRange(DateTime start, DateTime end) {
      ref.read(auditDateRangeProvider.notifier).state = DateTimeRange(
        start: start,
        end: DateTime(end.year, end.month, end.day, 23, 59, 59),
      );
    }

    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterChip(
                label: const Text('اليوم'),
                selected: range.start.day == now.day &&
                    range.start.month == now.month,
                onSelected: (_) => updateRange(now, now),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('هذا الأسبوع'),
                selected: range.start.isAfter(
                      now.subtract(Duration(days: now.weekday)),
                    ) &&
                    range.start.day != now.day,
                onSelected: (_) {
                  final start = now.subtract(Duration(days: now.weekday - 1));
                  updateRange(start, now);
                },
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('هذا الشهر'),
                selected: range.start.day == 1 && range.start.month == now.month,
                onSelected: (_) {
                  final start = DateTime(now.year, now.month, 1);
                  updateRange(start, now);
                },
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('فترة مخصصة'),
                selected: false,
                onSelected: (_) async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: now.subtract(const Duration(days: 3650)),
                    lastDate: now.add(const Duration(days: 3650)),
                    initialDateRange: range,
                  );
                  if (picked != null) {
                    updateRange(picked.start, picked.end);
                  }
                },
              ),
              const SizedBox(width: 12),
              Text(
                '${DateFormats.dayMonthYear.format(range.start)} - ${DateFormats.dayMonthYear.format(range.end)}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.person_search_rounded,
                size: 20, color: Colors.white70),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String?>(
                value: selectedDoctorId,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelText: 'فلترة حسب الطبيب (جرد شهري)',
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('الكل (العيادة بالكامل)'),
                  ),
                  ...doctors.map(
                    (d) => DropdownMenuItem(
                      value: d.id,
                      child: Text(d.fullName),
                    ),
                  ),
                ],
                onChanged: (val) {
                  ref.read(selectedAuditDoctorIdProvider.notifier).state = val;
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              onPressed: onPrint,
              icon: const Icon(Icons.print_rounded),
              tooltip: 'طباعة التقرير',
            ),
          ],
        ),
      ],
    );
  }
}

class _PaymentFormSheet extends ConsumerStatefulWidget {
  const _PaymentFormSheet();

  @override
  ConsumerState<_PaymentFormSheet> createState() => _PaymentFormSheetState();
}

class _PaymentFormSheetState extends ConsumerState<_PaymentFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _paidController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _date = DateTime.now();
  PaymentMethod _method = PaymentMethod.cash;
  String? _patientId;
  String? _doctorId;

  @override
  void dispose() {
    _amountController.dispose();
    _paidController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      initialDate: _date,
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _save(List<Patient> patients) async {
    if (!_formKey.currentState!.validate()) return;
    if (patients.isEmpty || _patientId == null) return;
    final patient = patients.firstWhere(
      (item) => item.id == _patientId,
      orElse: () => patients.first,
    );
    final amount = CurrencyFormat.parseLoose(_amountController.text);
    final paid = CurrencyFormat.parseLoose(_paidController.text);
    if (amount == null || paid == null) return;

    final doctors = ref.read(doctorsStreamProvider).value ?? const [];
    final doctor =
        _doctorId != null ? doctors.firstWhere((d) => d.id == _doctorId) : null;

    // Fixed salary doctors don't get transaction-based shares
    final commission = doctor?.paymentType == DoctorPaymentType.commission
        ? (doctor?.commissionPercent ?? 0)
        : 0.0;

    await ref.read(paymentEditorControllerProvider.notifier).create(
          patientId: patient.id,
          patientName: patient.displayName,
          amount: amount,
          paid: paid,
          method: _method,
          date: _date,
          notes: _notesController.text,
          doctorId: doctor?.id,
          doctorName: doctor?.fullName,
          doctorCommissionPercent: commission,
        );
    if (!mounted) return;
    final state = ref.read(paymentEditorControllerProvider);
    if (state.hasError) return;
    final tr = context.l10n.tr;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(tr('savedSuccessfully'))));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final patients = ref.watch(patientsStreamProvider).value ?? const [];
    final editorState = ref.watch(paymentEditorControllerProvider);
    final tr = context.l10n.tr;
    if (patients.isNotEmpty && _patientId == null) {
      _patientId = patients.first.id;
    }

    ref.listen(paymentEditorControllerProvider, (_, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('addPayment'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                key: ValueKey('payment_patient_${_patientId ?? 'none'}'),
                initialValue: _patientId,
                items: patients
                    .map(
                      (patient) => DropdownMenuItem(
                        value: patient.id,
                        child: Text(patient.displayName),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _patientId = value),
                validator: (value) =>
                    value == null ? tr('requiredField') : null,
                decoration: InputDecoration(labelText: tr('selectPatient')),
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, child) {
                  final doctors =
                      ref.watch(doctorsStreamProvider).value ?? const [];
                  return DropdownButtonFormField<String>(
                    value: _doctorId,
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('بدون طبيب'),
                      ),
                      ...doctors.map(
                        (doctor) => DropdownMenuItem(
                          value: doctor.id,
                          child: Text(doctor.fullName),
                        ),
                      ),
                    ],
                    onChanged: (value) => setState(() => _doctorId = value),
                    decoration: const InputDecoration(labelText: 'اختر الطبيب'),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: tr('amount')),
                validator: (value) {
                  final parsed = CurrencyFormat.parseLoose(value ?? '');
                  if (parsed == null || parsed <= 0) {
                    return tr('requiredField');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _paidController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: tr('paid')),
                validator: (value) {
                  final parsed = CurrencyFormat.parseLoose(value ?? '');
                  final amount = CurrencyFormat.parseLoose(
                    _amountController.text,
                  );
                  if (parsed == null || parsed < 0) {
                    return tr('requiredField');
                  }
                  if (amount != null && parsed > amount) {
                    return tr('paid');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<PaymentMethod>(
                key: ValueKey('payment_method_${_method.name}'),
                initialValue: _method,
                items: [
                  DropdownMenuItem(
                    value: PaymentMethod.cash,
                    child: Text(tr('cash')),
                  ),
                  DropdownMenuItem(
                    value: PaymentMethod.card,
                    child: Text(tr('card')),
                  ),
                  DropdownMenuItem(
                    value: PaymentMethod.transfer,
                    child: Text(tr('transfer')),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _method = value);
                  }
                },
                decoration: InputDecoration(labelText: tr('method')),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today_rounded),
                label: Text(DateFormats.dayMonthYear.format(_date)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: '${tr('notes')} (${tr('optional')})',
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: editorState.isLoading
                      ? null
                      : () => _save(patients),
                  child: Text(tr('save')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
