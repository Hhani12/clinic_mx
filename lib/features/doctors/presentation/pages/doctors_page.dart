import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/doctor_profile.dart';
import '../providers/doctors_providers.dart';

class DoctorsPage extends ConsumerWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorsAsync = ref.watch(doctorsStreamProvider);
    final statsMap = ref.watch(monthlyDoctorStatsProvider).value ?? const {};
    final clinicId = ref.watch(currentClinicIdProvider);

    return ClinicScaffold(
      title: 'إدارة الأطباء',
      selectedRoute: RoutePaths.doctors,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openDoctorForm(context),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('إضافة طبيب'),
      ),
      body: doctorsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (doctors) {
          if (doctors.isEmpty) {
            return const Center(child: Text('لا يوجد أطباء بعد'));
          }
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              final stats = statsMap[doctor.id] ?? DoctorMonthlyStats.empty;
              return GlassCard(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            doctor.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        if (!doctor.isActive)
                          const Chip(
                            label: Text('غير نشط'),
                            visualDensity: VisualDensity.compact,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      [
                        if ((doctor.specialty ?? '').isNotEmpty)
                          doctor.specialty!,
                        if ((doctor.phone ?? '').isNotEmpty) doctor.phone!,
                      ].join(' • '),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'الراتب الشهري: ${CurrencyFormat.iqd(doctor.monthlySalaryIqd)}',
                    ),
                    Text(
                      'نسبة العمليات: ${doctor.commissionPercent.toStringAsFixed(1)}%',
                    ),
                    const SizedBox(height: 6),
                    Text('عمليات هذا الشهر: ${stats.totalProcedures}'),
                    if (stats.actionCounts.isNotEmpty)
                      Text(
                        'تفصيل الإجراءات: ${_actionsSummary(stats.actionCounts)}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () =>
                              _openDoctorForm(context, existing: doctor),
                          icon: const Icon(Icons.edit_rounded),
                          label: const Text('تعديل'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => ref
                              .read(doctorsEditorControllerProvider.notifier)
                              .updateDoctor(
                                doctor.copyWith(isActive: !doctor.isActive),
                              ),
                          icon: Icon(
                            doctor.isActive
                                ? Icons.pause_circle_outline_rounded
                                : Icons.play_circle_outline_rounded,
                          ),
                          label: Text(doctor.isActive ? 'تعطيل' : 'تفعيل'),
                        ),
                        TextButton.icon(
                          onPressed: clinicId == null
                              ? null
                              : () => ref
                                    .read(
                                      doctorsEditorControllerProvider.notifier,
                                    )
                                    .delete(
                                      clinicId: clinicId,
                                      doctorId: doctor.id,
                                    ),
                          icon: const Icon(Icons.delete_outline_rounded),
                          label: const Text('حذف'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openDoctorForm(
    BuildContext context, {
    DoctorProfile? existing,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _DoctorFormSheet(existing: existing),
    );
  }

  static String _actionsSummary(Map<String, int> actionCounts) {
    final sorted = actionCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.map((entry) => '${entry.key}: ${entry.value}').join(' | ');
  }
}

class _DoctorFormSheet extends ConsumerStatefulWidget {
  const _DoctorFormSheet({this.existing});

  final DoctorProfile? existing;

  @override
  ConsumerState<_DoctorFormSheet> createState() => _DoctorFormSheetState();
}

class _DoctorFormSheetState extends ConsumerState<_DoctorFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  final _salaryController = TextEditingController();
  final _commissionController = TextEditingController();

  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    if (existing != null) {
      _nameController.text = existing.fullName;
      _phoneController.text = existing.phone ?? '';
      _specialtyController.text = existing.specialty ?? '';
      _addressController.text = existing.address ?? '';
      _notesController.text = existing.notes ?? '';
      _salaryController.text = existing.monthlySalaryIqd.toStringAsFixed(0);
      _commissionController.text = existing.commissionPercent.toStringAsFixed(
        1,
      );
      _isActive = existing.isActive;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _specialtyController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    _salaryController.dispose();
    _commissionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final salary = CurrencyFormat.parseLoose(_salaryController.text);
    final commission = CurrencyFormat.parseLoose(_commissionController.text);
    if (salary == null || commission == null) return;

    final notifier = ref.read(doctorsEditorControllerProvider.notifier);
    final existing = widget.existing;
    if (existing == null) {
      await notifier.create(
        fullName: _nameController.text,
        phone: _phoneController.text,
        specialty: _specialtyController.text,
        address: _addressController.text,
        notes: _notesController.text,
        monthlySalaryIqd: salary,
        commissionPercent: commission,
        isActive: _isActive,
      );
    } else {
      await notifier.updateDoctor(
        existing.copyWith(
          fullName: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
          specialty: _specialtyController.text.trim(),
          address: _addressController.text.trim(),
          notes: _notesController.text.trim(),
          monthlySalaryIqd: salary,
          commissionPercent: commission,
          isActive: _isActive,
        ),
      );
    }

    if (!mounted) return;
    final state = ref.read(doctorsEditorControllerProvider);
    if (state.hasError) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(doctorsEditorControllerProvider).isLoading;

    ref.listen(doctorsEditorControllerProvider, (_, next) {
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
                widget.existing == null ? 'إضافة طبيب' : 'تعديل بيانات الطبيب',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'اسم الطبيب'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'مطلوب';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'الهاتف'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _specialtyController,
                decoration: const InputDecoration(labelText: 'الاختصاص'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'العنوان'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _salaryController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'الراتب الثابت الشهري (IQD)',
                ),
                validator: (value) {
                  final parsed = CurrencyFormat.parseLoose(value ?? '');
                  if (parsed == null || parsed < 0) return 'رقم غير صحيح';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _commissionController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'نسبة الطبيب لكل عملية (%)',
                ),
                validator: (value) {
                  final parsed = CurrencyFormat.parseLoose(value ?? '');
                  if (parsed == null || parsed < 0 || parsed > 100) {
                    return 'أدخل نسبة من 0 إلى 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'ملاحظات'),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
                title: const Text('نشط'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: isLoading ? null : _save,
                  icon: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_rounded),
                  label: const Text('حفظ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
