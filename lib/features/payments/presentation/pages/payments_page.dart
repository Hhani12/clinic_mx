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
import '../../domain/entities/payment_transaction.dart';
import '../providers/payments_providers.dart';

class PaymentsPage extends ConsumerWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(allPaymentsProvider);
    final totals = ref.watch(paymentsTotalsProvider);
    final clinicId = ref.watch(currentClinicIdProvider);
    final tr = context.l10n.tr;

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
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _TotalCard(title: tr('today'), value: totals['day'] ?? 0),
              _TotalCard(title: tr('week'), value: totals['week'] ?? 0),
              _TotalCard(title: tr('month'), value: totals['month'] ?? 0),
            ],
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
                                Text(
                                  DateFormats.dayMonthYear.format(payment.date),
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
  const _TotalCard({required this.title, required this.value});

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 4),
            Text(
              CurrencyFormat.iqd(value),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
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

    await ref
        .read(paymentEditorControllerProvider.notifier)
        .create(
          patientId: patient.id,
          patientName: patient.displayName,
          amount: amount,
          paid: paid,
          method: _method,
          date: _date,
          notes: _notesController.text,
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
