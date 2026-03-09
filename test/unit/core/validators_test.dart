import 'package:clinic/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators.arabicName', () {
    test('accepts valid Arabic triple name part', () {
      expect(Validators.arabicName('محمد'), isNull);
      expect(Validators.arabicName('عبد الرحمن'), isNull);
    });

    test('rejects empty and non-Arabic values', () {
      expect(Validators.arabicName(''), equals('required'));
      expect(Validators.arabicName('John'), equals('invalidArabicName'));
      expect(Validators.arabicName('123'), equals('invalidArabicName'));
    });
  });

  group('Validators.e164Phone', () {
    test('accepts valid E.164 numbers', () {
      expect(Validators.e164Phone('+9647712345678'), isNull);
      expect(Validators.e164Phone('+12025550123'), isNull);
    });

    test('rejects invalid phone formats', () {
      expect(Validators.e164Phone('07712345678'), equals('invalidPhone'));
      expect(Validators.e164Phone('+1'), equals('invalidPhone'));
      expect(Validators.e164Phone(''), equals('required'));
    });
  });
}
