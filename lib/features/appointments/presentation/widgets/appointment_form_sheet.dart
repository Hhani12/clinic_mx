import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/visit_status.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../patients/domain/entities/patient.dart';
import '../../../patients/presentation/providers/patients_providers.dart';
import '../../domain/entities/appointment.dart';
import '../providers/appointments_providers.dart';

class AppointmentFormSheet extends ConsumerStatefulWidget {
  const AppointmentFormSheet({
    super.key,
    this.appointment,
  });

  final Appointment? appointment;

  bool get isEdit => appointment != null;

  @override
  ConsumerState<AppointmentFormSheet> createState() => _AppointmentFormSheetState();
}

class _AppointmentFormSheetState extends ConsumerState<AppointmentFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _durationController = TextEditingController(text: '30');

  String? _selectedPatientId;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  VisitStatus _status = VisitStatus.scheduled;

  @override
  void initState() {
    super.initState();
    final appointment = widget.appointment;
    if (appointment != null) {
      _selectedPatientId = appointment.patientId;
      _reasonController.text = appointment.reason;
      _durationController.text = appointment.durationMinutes.toString();
      _selectedDate = appointment.startAt;
      _selectedTime = TimeOfDay.fromDateTime(appointment.startAt);
      _status = appointment.status;
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      initialDate: _selectedDate,
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  Future<void> _save(List<Patient> patients) async {
    if (!_formKey.currentState!.validate()) return;
    if (patients.isEmpty) return;
    final patient = patients.firstWhere(
      (item) => item.id == _selectedPatientId,
      orElse: () => patients.first,
    );
    final startAt = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    final durationMinutes = int.parse(_durationController.text.trim());

    final notifier = ref.read(appointmentEditorControllerProvider.notifier);

    if (widget.appointment == null) {
      await notifier.create(
        patientId: patient.id,
        patientName: patient.displayName,
        patientPhone: patient.phoneNumber,
        startAt: startAt,
        durationMinutes: durationMinutes,
        reason: _reasonController.text.trim(),
        status: _status,
      );
    } else {
      final updated = widget.appointment!.copyWith(
        patientId: patient.id,
        patientName: patient.displayName,
        patientPhone: patient.phoneNumber,
        startAt: startAt,
        durationMinutes: durationMinutes,
        reason: _reasonController.text.trim(),
        status: _status,
        updatedAt: DateTime.now(),
        reminderSent: false,
      );
      await notifier.updateAppointment(updated);
    }

    if (!mounted) return;
    final state = ref.read(appointmentEditorControllerProvider);
    if (state.hasError) return; // error snackbar shown by ref.listen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.tr('savedSuccessfully'))),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final patients = ref.watch(patientsStreamProvider).value ?? const <Patient>[];
    final editorState = ref.watch(appointmentEditorControllerProvider);
    final tr = context.l10n.tr;

    ref.listen(appointmentEditorControllerProvider, (_, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    if (patients.isNotEmpty && _selectedPatientId == null) {
      _selectedPatientId = patients.first.id;
    }

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
                tr(widget.isEdit ? 'update' : 'createAppointment'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                key: ValueKey('patient_${_selectedPatientId ?? 'none'}'),
                initialValue: _selectedPatientId,
                items: patients
                    .map(
                      (patient) => DropdownMenuItem(
                        value: patient.id,
                        child: Text(patient.displayName),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedPatientId = value),
                decoration: InputDecoration(labelText: tr('selectPatient')),
                validator: (value) =>
                    value == null ? tr('requiredField') : null,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_month_rounded),
                      label: Text(
                        '${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickTime,
                      icon: const Icon(Icons.schedule_rounded),
                      label: Text(
                        MaterialLocalizations.of(context).formatTimeOfDay(
                          _selectedTime,
                          alwaysUse24HourFormat: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: tr('durationMinutes')),
                validator: (value) {
                  final parsed = int.tryParse(value ?? '');
                  if (parsed == null || parsed < 5 || parsed > 240) {
                    return tr('requiredField');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(labelText: tr('appointmentReason')),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return tr('requiredField');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<VisitStatus>(
                key: ValueKey('status_${_status.value}'),
                initialValue: _status,
                items: VisitStatus.values
                    .map(
                      (status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.labelAr),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _status = value);
                  }
                },
                decoration: InputDecoration(labelText: tr('status')),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: editorState.isLoading ? null : () => _save(patients),
                  icon: editorState.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_rounded),
                  label: Text(tr('save')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
