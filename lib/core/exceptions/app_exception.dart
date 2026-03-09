import 'package:firebase_auth/firebase_auth.dart';

/// Typed application exception that converts Firebase errors into
/// user-facing Arabic messages without exposing internal SDK details.
class AppException implements Exception {
  const AppException(this.message, {this.code});

  final String message;
  final String? code;

  factory AppException.fromFirebase(FirebaseException e) {
    final msg = switch (e.code) {
      'permission-denied' => 'لا تملك صلاحية للقيام بهذا الإجراء',
      'not-found' => 'السجل المطلوب غير موجود',
      'unavailable' => 'الخدمة غير متاحة، تحقق من الاتصال بالإنترنت',
      'deadline-exceeded' => 'انتهت مهلة الطلب، حاول مرة أخرى',
      'already-exists' => 'السجل موجود مسبقاً',
      'resource-exhausted' => 'تجاوزت حد الطلبات، حاول لاحقاً',
      'unauthenticated' => 'يجب تسجيل الدخول أولاً',
      'cancelled' => 'تم إلغاء العملية',
      'data-loss' => 'حدث خطأ في البيانات، تواصل مع الدعم',
      'internal' => 'خطأ داخلي في الخادم',
      _ => 'حدث خطأ غير متوقع (${e.code})',
    };
    return AppException(msg, code: e.code);
  }

  factory AppException.fromAuth(FirebaseAuthException e) {
    final msg = switch (e.code) {
      'user-not-found' => 'البريد الإلكتروني غير مسجل',
      'wrong-password' => 'كلمة المرور غير صحيحة',
      'invalid-credential' => 'البريد الإلكتروني أو كلمة المرور غير صحيحة',
      'email-already-in-use' => 'البريد الإلكتروني مستخدم مسبقاً',
      'weak-password' => 'كلمة المرور ضعيفة جداً (6 أحرف على الأقل)',
      'invalid-email' => 'البريد الإلكتروني غير صالح',
      'network-request-failed' => 'فشل الاتصال بالشبكة',
      'too-many-requests' => 'عدد كبير من المحاولات، حاول لاحقاً',
      'user-disabled' => 'الحساب معطّل، تواصل مع الدعم',
      'operation-not-allowed' => 'هذه العملية غير مسموح بها',
      _ => 'خطأ في المصادقة (${e.code})',
    };
    return AppException(msg, code: e.code);
  }

  @override
  String toString() => message;
}
