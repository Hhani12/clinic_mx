import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A phone input field with a fixed +964 prefix for Iraqi numbers.
/// The user only types the local number (e.g., 7XXXXXXXXX).
/// The full E.164 number (+9647XXXXXXXXX) is returned via [onFullNumberChanged].
class IraqiPhoneField extends StatefulWidget {
  const IraqiPhoneField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
  });

  /// Controller holds only the local part (without +964).
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;

  /// Combines "+964" with the local value.
  static String fullNumber(String localValue) {
    final cleaned = localValue.trim().replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.isEmpty) return '';
    return '+964$cleaned';
  }

  /// Extracts the local part from a full E.164 number for populating the controller.
  static String extractLocal(String fullPhone) {
    final trimmed = fullPhone.trim();
    if (trimmed.startsWith('+964')) {
      return trimmed.substring(4);
    }
    if (trimmed.startsWith('00964')) {
      return trimmed.substring(5);
    }
    if (trimmed.startsWith('964') && trimmed.length > 10) {
      return trimmed.substring(3);
    }
    // Return as-is if it doesn't match Iraq prefix
    return trimmed.replaceAll('+', '');
  }

  @override
  State<IraqiPhoneField> createState() => _IraqiPhoneFieldState();
}

class _IraqiPhoneFieldState extends State<IraqiPhoneField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      textDirection: TextDirection.ltr,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10), // Iraqi local numbers are max 10 digits
      ],
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          width: 72,
          child: const Text(
            '+964',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ),
        hintText: '7XXXXXXXXX',
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
      ),
      validator: widget.validator,
    );
  }
}
