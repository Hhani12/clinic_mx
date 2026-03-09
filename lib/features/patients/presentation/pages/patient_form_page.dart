import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/iraq_governorates.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/clinic_scaffold.dart';
import '../../../../core/widgets/glass_button.dart';
import '../../../../core/widgets/iraqi_phone_field.dart';
import '../../domain/entities/patient.dart';
import '../providers/patients_providers.dart';

class PatientFormPage extends ConsumerStatefulWidget {
  const PatientFormPage({super.key, this.patientId});

  final String? patientId;

  bool get isEdit => patientId != null;

  @override
  ConsumerState<PatientFormPage> createState() => _PatientFormPageState();
}

class _PatientFormPageState extends ConsumerState<PatientFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneLocalController = TextEditingController();
  final _districtController = TextEditingController();
  final _addressController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _reasonController = TextEditingController();
  final _medicalNotesController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _chronicController = TextEditingController();

  String? _selectedGovernorate;
  PatientGender? _gender;
  DateTime? _dob;
  bool _didPopulate = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _fatherNameController.dispose();
    _lastNameController.dispose();
    _phoneLocalController.dispose();
    _districtController.dispose();
    _addressController.dispose();
    _nationalIdController.dispose();
    _reasonController.dispose();
    _medicalNotesController.dispose();
    _allergiesController.dispose();
    _chronicController.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: _dob ?? DateTime(1995),
    );
    if (picked != null) {
      setState(() => _dob = picked);
    }
  }

  void _populate(Patient patient) {
    if (_didPopulate) return;
    _didPopulate = true;
    _firstNameController.text = patient.firstName;
    _fatherNameController.text = patient.fatherName;
    _lastNameController.text = patient.lastName;
    // Extract local part from full phone number
    _phoneLocalController.text =
        IraqiPhoneField.extractLocal(patient.phoneNumber);
    _selectedGovernorate = patient.city;
    _districtController.text = patient.district ?? '';
    _addressController.text = patient.detailedAddress ?? '';
    _nationalIdController.text = patient.nationalId ?? '';
    _reasonController.text = patient.reasonForVisit ?? '';
    _medicalNotesController.text = patient.medicalNotes ?? '';
    _allergiesController.text = patient.allergies.join(', ');
    _chronicController.text = patient.chronicDiseases.join(', ');
    _gender = patient.gender;
    _dob = patient.dob;
  }

  Future<void> _save([Patient? patient]) async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(patientFormControllerProvider.notifier);
    final allergies = _allergiesController.text.split(',');
    final chronic = _chronicController.text.split(',');
    // Build full E.164 phone from local part
    final fullPhone =
        IraqiPhoneField.fullNumber(_phoneLocalController.text);

    if (patient == null) {
      final id = await notifier.create(
        firstName: _firstNameController.text,
        fatherName: _fatherNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: fullPhone,
        city: _selectedGovernorate,
        district: _districtController.text,
        detailedAddress: _addressController.text,
        dob: _dob,
        gender: _gender,
        nationalId: _nationalIdController.text,
        reasonForVisit: _reasonController.text,
        medicalNotes: _medicalNotesController.text,
        allergies: allergies,
        chronicDiseases: chronic,
      );
      if (!mounted) return;
      final state = ref.read(patientFormControllerProvider);
      if (state.hasError) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.tr('savedSuccessfully'))),
      );
      context.go(RoutePaths.patientProfile.replaceFirst(':patientId', id));
      return;
    }

    await notifier.updatePatient(
      patient,
      firstName: _firstNameController.text,
      fatherName: _fatherNameController.text,
      lastName: _lastNameController.text,
      phoneNumber: fullPhone,
      city: _selectedGovernorate,
      district: _districtController.text,
      detailedAddress: _addressController.text,
      dob: _dob,
      gender: _gender,
      nationalId: _nationalIdController.text,
      reasonForVisit: _reasonController.text,
      medicalNotes: _medicalNotesController.text,
      allergies: allergies,
      chronicDiseases: chronic,
    );
    if (!mounted) return;
    final state = ref.read(patientFormControllerProvider);
    if (state.hasError) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.tr('savedSuccessfully'))),
    );
    context.go(RoutePaths.patientProfile.replaceFirst(':patientId', patient.id));
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(patientFormControllerProvider);
    ref.listen(patientFormControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return ClinicScaffold(
      title: context.l10n.tr(widget.isEdit ? 'editPatient' : 'addPatient'),
      selectedRoute: RoutePaths.patients,
      body: widget.isEdit
          ? ref
                .watch(patientByIdProvider(widget.patientId!))
                .when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text(error.toString())),
                  data: (patient) {
                    if (patient == null) {
                      return Center(child: Text(context.l10n.tr('noData')));
                    }
                    _populate(patient);
                    return _PatientForm(
                      formKey: _formKey,
                      firstNameController: _firstNameController,
                      fatherNameController: _fatherNameController,
                      lastNameController: _lastNameController,
                      phoneLocalController: _phoneLocalController,
                      selectedGovernorate: _selectedGovernorate,
                      onGovernorateChanged: (v) =>
                          setState(() => _selectedGovernorate = v),
                      districtController: _districtController,
                      addressController: _addressController,
                      nationalIdController: _nationalIdController,
                      reasonController: _reasonController,
                      medicalNotesController: _medicalNotesController,
                      allergiesController: _allergiesController,
                      chronicController: _chronicController,
                      gender: _gender,
                      dob: _dob,
                      onPickDob: _pickDob,
                      onGenderChanged: (value) => setState(() => _gender = value),
                      onSave: formState.isLoading ? null : () => _save(patient),
                    );
                  },
                )
          : _PatientForm(
              formKey: _formKey,
              firstNameController: _firstNameController,
              fatherNameController: _fatherNameController,
              lastNameController: _lastNameController,
              phoneLocalController: _phoneLocalController,
              selectedGovernorate: _selectedGovernorate,
              onGovernorateChanged: (v) =>
                  setState(() => _selectedGovernorate = v),
              districtController: _districtController,
              addressController: _addressController,
              nationalIdController: _nationalIdController,
              reasonController: _reasonController,
              medicalNotesController: _medicalNotesController,
              allergiesController: _allergiesController,
              chronicController: _chronicController,
              gender: _gender,
              dob: _dob,
              onPickDob: _pickDob,
              onGenderChanged: (value) => setState(() => _gender = value),
              onSave: formState.isLoading ? null : () => _save(),
            ),
    );
  }
}

class _PatientForm extends StatelessWidget {
  const _PatientForm({
    required this.formKey,
    required this.firstNameController,
    required this.fatherNameController,
    required this.lastNameController,
    required this.phoneLocalController,
    required this.selectedGovernorate,
    required this.onGovernorateChanged,
    required this.districtController,
    required this.addressController,
    required this.nationalIdController,
    required this.reasonController,
    required this.medicalNotesController,
    required this.allergiesController,
    required this.chronicController,
    required this.gender,
    required this.dob,
    required this.onPickDob,
    required this.onGenderChanged,
    required this.onSave,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController fatherNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneLocalController;
  final String? selectedGovernorate;
  final ValueChanged<String?> onGovernorateChanged;
  final TextEditingController districtController;
  final TextEditingController addressController;
  final TextEditingController nationalIdController;
  final TextEditingController reasonController;
  final TextEditingController medicalNotesController;
  final TextEditingController allergiesController;
  final TextEditingController chronicController;
  final PatientGender? gender;
  final DateTime? dob;
  final VoidCallback onPickDob;
  final ValueChanged<PatientGender?> onGenderChanged;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final tr = context.l10n.tr;
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _sizedField(
                width: 300,
                child: TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: tr('firstName')),
                  validator: (value) {
                    final result = Validators.arabicName(value);
                    if (result == 'required') return tr('requiredField');
                    if (result == 'invalidArabicName') return tr(result!);
                    return null;
                  },
                ),
              ),
              _sizedField(
                width: 300,
                child: TextFormField(
                  controller: fatherNameController,
                  decoration: InputDecoration(labelText: tr('fatherName')),
                  validator: (value) {
                    final result = Validators.arabicName(value);
                    if (result == 'required') return tr('requiredField');
                    if (result == 'invalidArabicName') return tr(result!);
                    return null;
                  },
                ),
              ),
              _sizedField(
                width: 300,
                child: TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: tr('lastName')),
                  validator: (value) {
                    final result = Validators.arabicName(value);
                    if (result == 'required') return tr('requiredField');
                    if (result == 'invalidArabicName') return tr(result!);
                    return null;
                  },
                ),
              ),
              // Iraqi phone field with +964 prefix
              _sizedField(
                width: 300,
                child: IraqiPhoneField(
                  controller: phoneLocalController,
                  labelText: tr('phone'),
                  validator: (value) {
                    final result = Validators.iraqiLocalPhone(value);
                    if (result == 'required') return tr('requiredField');
                    if (result == 'invalidPhone') return tr(result!);
                    return null;
                  },
                ),
              ),
              _sizedField(
                width: 200,
                child: DropdownButtonFormField<PatientGender>(
                  key: ValueKey('gender_${gender?.name ?? 'none'}'),
                  initialValue: gender,
                  items: [
                    DropdownMenuItem(
                      value: PatientGender.male,
                      child: Text(tr('male')),
                    ),
                    DropdownMenuItem(
                      value: PatientGender.female,
                      child: Text(tr('female')),
                    ),
                  ],
                  onChanged: onGenderChanged,
                  decoration: InputDecoration(
                    labelText: '${tr('gender')} (${tr('optional')})',
                  ),
                ),
              ),
              _sizedField(
                width: 220,
                child: OutlinedButton.icon(
                  onPressed: onPickDob,
                  icon: const Icon(Icons.calendar_today_rounded),
                  label: Text(
                    dob == null
                        ? '${tr('dob')} (${tr('optional')})'
                        : '${tr('dob')}: ${dob!.year}/${dob!.month}/${dob!.day}',
                  ),
                ),
              ),
              // Governorate dropdown instead of free text city
              _sizedField(
                width: 300,
                child: DropdownButtonFormField<String>(
                  key: ValueKey('gov_${selectedGovernorate ?? 'none'}'),
                  initialValue: selectedGovernorate,
                  items: IraqGovernorate.all
                      .map(
                        (gov) => DropdownMenuItem(
                          value: gov.ar,
                          child: Text('${gov.ar} (${gov.en})'),
                        ),
                      )
                      .toList(),
                  onChanged: onGovernorateChanged,
                  decoration: InputDecoration(
                    labelText: '${tr('governorate')} (${tr('optional')})',
                  ),
                  isExpanded: true,
                ),
              ),
              _sizedField(
                width: 300,
                child: TextFormField(
                  controller: districtController,
                  decoration: InputDecoration(
                    labelText: '${tr('district')} (${tr('optional')})',
                  ),
                ),
              ),
              _sizedField(
                width: 612,
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: '${tr('detailedAddress')} (${tr('optional')})',
                  ),
                ),
              ),
              _sizedField(
                width: 300,
                child: TextFormField(
                  controller: nationalIdController,
                  decoration: InputDecoration(
                    labelText: '${tr('nationalId')} (${tr('optional')})',
                  ),
                ),
              ),
              _sizedField(
                width: 612,
                child: TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    labelText: '${tr('reasonForVisit')} (${tr('optional')})',
                  ),
                ),
              ),
              _sizedField(
                width: 612,
                child: TextFormField(
                  controller: medicalNotesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: '${tr('medicalNotes')} (${tr('optional')})',
                  ),
                ),
              ),
              _sizedField(
                width: 612,
                child: TextFormField(
                  controller: allergiesController,
                  decoration: InputDecoration(
                    labelText:
                        '${tr('allergies')} (${tr('optional')}) - comma separated',
                  ),
                ),
              ),
              _sizedField(
                width: 612,
                child: TextFormField(
                  controller: chronicController,
                  decoration: InputDecoration(
                    labelText:
                        '${tr('chronicDiseases')} (${tr('optional')}) - comma separated',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              GlassButton(
                label: tr('save'),
                onPressed: onSave,
                icon: Icons.save_rounded,
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () => context.pop(),
                child: Text(tr('cancel')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sizedField({required double width, required Widget child}) {
    return SizedBox(width: width, child: child);
  }
}
