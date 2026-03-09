import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../appointments/presentation/providers/appointments_providers.dart';
import '../../../payments/presentation/providers/payments_providers.dart';

final todayVisitsCountProvider = Provider<int>((ref) {
  return ref.watch(todayAppointmentsProvider).value?.length ?? 0;
});

final upcomingVisitsCountProvider = Provider<int>((ref) {
  return ref.watch(upcomingWeekVisitsCountProvider).value ?? 0;
});

final pendingPaymentsTotalProvider = Provider<double>((ref) {
  final payments = ref.watch(allPaymentsProvider).value ?? const [];
  return payments.fold<double>(0, (sum, item) => sum + item.remaining);
});
