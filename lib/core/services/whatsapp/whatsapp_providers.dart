import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/settings/presentation/providers/settings_providers.dart';
import 'whatsapp_service.dart';

final whatsAppServiceRawProvider = Provider<WhatsAppService?>((ref) {
  final settings = ref.watch(clinicSettingsProvider).value;
  if (settings == null || !settings.whatsAppEnabled) return null;

  // These should ideally be in ENV or a secure part of Firestore
  // For now we get what we can from settings
  final phoneId = settings.whatsAppPhoneNumberId;

  // The Access Token is SENSITIVE and should NOT be in Firestore 'settings'
  // But for the sake of this demo/request, we assume it's available or we provide a placeholder
  const placeholderToken = 'YOUR_META_PERMANENT_TOKEN';

  if (phoneId == null || phoneId.isEmpty) return null;

  return WhatsAppService(phoneNumberId: phoneId, accessToken: placeholderToken);
});

final whatsAppServiceProvider = Provider<WhatsAppService?>((ref) {
  return ref.watch(whatsAppServiceRawProvider);
});
