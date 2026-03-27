import 'dart:convert';
import 'package:http/http.dart' as http;

class WhatsAppService {
  WhatsAppService({required this.phoneNumberId, required this.accessToken});

  final String phoneNumberId;
  final String accessToken;

  static const String _baseUrl = 'https://graph.facebook.com/v18.0';

  Future<bool> sendTemplateReminder({
    required String to,
    required String patientName,
    required String appointmentDate,
    required String clinicName,
  }) async {
    final url = Uri.parse('$_baseUrl/$phoneNumberId/messages');

    // Clean phone number (remove +, spaces, ensure country code)
    final cleanedTo = to.replaceAll(RegExp(r'[^\d]'), '');

    final body = {
      "messaging_product": "whatsapp",
      "to": cleanedTo,
      "type": "template",
      "template": {
        "name": "appointment_reminder",
        "language": {"code": "ar"},
        "components": [
          {
            "type": "body",
            "parameters": [
              {"type": "text", "text": patientName},
              {"type": "text", "text": appointmentDate},
              {"type": "text", "text": clinicName},
            ],
          },
        ],
      },
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
