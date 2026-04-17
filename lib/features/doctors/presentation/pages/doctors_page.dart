import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routing/route_paths.dart';
import '../../../../core/services/firebase/storage_service.dart';
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
                        // Profile picture avatar
                        _DoctorAvatar(
                          url: doctor.profilePictureUrl,
                          name: doctor.fullName,
                          size: 44,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.fullName.isNotEmpty
                                    ? doctor.fullName
                                    : 'طبيب بدون اسم',
                                style:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                              if ([
                                doctor.specialty,
                                doctor.phone,
                              ].any((s) => (s ?? '').isNotEmpty))
                                Text([
                                  if ((doctor.specialty ?? '').isNotEmpty)
                                    doctor.specialty!,
                                  if ((doctor.phone ?? '').isNotEmpty)
                                    doctor.phone!,
                                ].join(' • ')),
                            ],
                          ),
                        ),
                        if (!doctor.isActive)
                          const Chip(
                            label: Text('غير نشط'),
                            visualDensity: VisualDensity.compact,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (doctor.paymentType == DoctorPaymentType.fixed)
                      Text(
                        'نوع الدفع: راتب ثابت (${CurrencyFormat.iqd(doctor.monthlySalaryIqd)})',
                      )
                    else
                      Text(
                        'نوع الدفع: نسبة مئوية (${doctor.commissionPercent.toStringAsFixed(1)}%)',
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

// ---------------------------------------------------------------------------
// Doctor avatar widget
// ---------------------------------------------------------------------------
class _DoctorAvatar extends StatelessWidget {
  const _DoctorAvatar({this.url, this.name = '', this.size = 44});
  final String? url;
  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final hasUrl = url != null && url!.isNotEmpty;
    final initials = _initials(name);

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.white.withValues(alpha: 0.12),
      backgroundImage: hasUrl ? NetworkImage(url!) : null,
      child: hasUrl
          ? null
          : Text(
              initials,
              style: TextStyle(
                fontSize: size * 0.36,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            ),
    );
  }

  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

// ---------------------------------------------------------------------------
// Doctor form sheet
// ---------------------------------------------------------------------------
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
  DoctorPaymentType _paymentType = DoctorPaymentType.commission;
  String? _profilePictureUrl;
  Uint8List? _pickedImageBytes;
  bool _isUploadingImage = false;

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
      _salaryController.text = existing.monthlySalaryIqd > 0
          ? existing.monthlySalaryIqd.toStringAsFixed(0)
          : '';
      _commissionController.text = existing.commissionPercent > 0
          ? existing.commissionPercent.toStringAsFixed(1)
          : '';
      _isActive = existing.isActive;
      _profilePictureUrl = existing.profilePictureUrl;
      _paymentType = existing.paymentType;
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

  Future<void> _pickProfileImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    Uint8List? bytes = file.bytes;
    if (bytes == null && !kIsWeb && file.path != null) {
      try {
        bytes = await File(file.path!).readAsBytes();
      } catch (_) {
        return;
      }
    }
    if (bytes == null) return;

    setState(() => _pickedImageBytes = bytes);
  }

  Future<String?> _uploadProfileImage() async {
    if (_pickedImageBytes == null) return _profilePictureUrl;

    final clinicId = ref.read(currentClinicIdProvider);
    if (clinicId == null || clinicId.isEmpty) return null;

    setState(() => _isUploadingImage = true);
    try {
      final url =
          await ref.read(storageServiceProvider).uploadInvestigationFile(
                clinicId: clinicId,
                patientId: 'doctors',
                fileName: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
                bytes: _pickedImageBytes!,
                contentType: 'image/jpeg',
              );
      return url;
    } catch (_) {
      return _profilePictureUrl;
    } finally {
      if (mounted) setState(() => _isUploadingImage = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final salaryText = _salaryController.text.trim();
    final commissionText = _commissionController.text.trim();
    final salary = salaryText.isEmpty
        ? 0.0
        : CurrencyFormat.parseLoose(salaryText) ?? 0.0;
    final commission = commissionText.isEmpty
        ? 0.0
        : CurrencyFormat.parseLoose(commissionText) ?? 0.0;

    // Upload profile image if picked
    final imageUrl = await _uploadProfileImage();

    final notifier = ref.read(doctorsEditorControllerProvider.notifier);
    final existing = widget.existing;
    if (existing == null) {
      await notifier.create(
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        specialty: _specialtyController.text.trim(),
        address: _addressController.text.trim(),
        notes: _notesController.text.trim(),
        profilePictureUrl: imageUrl,
        monthlySalaryIqd: salary,
        commissionPercent: commission,
        paymentType: _paymentType,
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
          profilePictureUrl: imageUrl,
          monthlySalaryIqd: salary,
          commissionPercent: commission,
          paymentType: _paymentType,
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
              const SizedBox(height: 16),

              // Profile picture picker
              Center(
                child: GestureDetector(
                  onTap: _pickProfileImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.white.withValues(alpha: 0.12),
                        backgroundImage: _pickedImageBytes != null
                            ? MemoryImage(_pickedImageBytes!)
                            : (_profilePictureUrl != null &&
                                    _profilePictureUrl!.isNotEmpty)
                                ? NetworkImage(_profilePictureUrl!)
                                : null,
                        child: (_pickedImageBytes == null &&
                                (_profilePictureUrl == null ||
                                    _profilePictureUrl!.isEmpty))
                            ? const Icon(
                                Icons.person_rounded,
                                size: 38,
                                color: Colors.white38,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (_isUploadingImage)
                        const Positioned.fill(
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  'اضغط لتغيير الصورة (اختياري)',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'اسم الطبيب'),
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
              const SizedBox(height: 16),
              const Text('طريقة احتساب الدفع (إجباري):'),
              const SizedBox(height: 8),
              SegmentedButton<DoctorPaymentType>(
                segments: const [
                  ButtonSegment(
                    value: DoctorPaymentType.fixed,
                    label: Text('راتب ثابت'),
                    icon: Icon(Icons.money_rounded),
                  ),
                  ButtonSegment(
                    value: DoctorPaymentType.commission,
                    label: Text('نسبة مئوية'),
                    icon: Icon(Icons.percent_rounded),
                  ),
                ],
                selected: {_paymentType},
                onSelectionChanged: (value) {
                  setState(() => _paymentType = value.first);
                },
              ),
              const SizedBox(height: 16),
              if (_paymentType == DoctorPaymentType.fixed)
                TextFormField(
                  controller: _salaryController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'الراتب الثابت الشهري (IQD)',
                  ),
                  validator: (value) {
                    if (_paymentType == DoctorPaymentType.fixed) {
                      if (value == null || value.trim().isEmpty) {
                        return 'يرجى إدخال الراتب';
                      }
                    }
                    return null;
                  },
                )
              else
                TextFormField(
                  controller: _commissionController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'نسبة الطبيب لكل عملية (%)',
                  ),
                  validator: (value) {
                    if (_paymentType == DoctorPaymentType.commission) {
                      if (value == null || value.trim().isEmpty) {
                        return 'يرجى إدخال النسبة';
                      }
                      final parsed = CurrencyFormat.parseLoose(value);
                      if (parsed == null || parsed < 0 || parsed > 100) {
                        return 'أدخل نسبة من 0 إلى 100';
                      }
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
                  onPressed:
                      (isLoading || _isUploadingImage) ? null : _save,
                  icon: (isLoading || _isUploadingImage)
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
