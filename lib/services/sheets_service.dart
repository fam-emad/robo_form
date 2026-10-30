import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/sheets_config.dart';

class SheetsException implements Exception {
  final String message;
  SheetsException(this.message);
  @override
  String toString() => message;
}

class SheetsService {
  SheetsService._();

  static Future<void> submit(Map<String, dynamic> data) async {
    final uri = Uri.parse(kSheetsWebAppUrl);
    final body = jsonEncode({...data, 'secret': kSheetsSecret});

    http.Response res;
    try {
      // text/plain عشان نتفادى CORS preflight على الويب (Apps Script مبيدعمش OPTIONS).
      res = await http
          .post(uri,
              headers: {'Content-Type': 'text/plain;charset=utf-8'}, body: body)
          .timeout(const Duration(seconds: 25));
    } catch (_) {
      throw SheetsException(
          'Could not reach the server. Check your internet and try again.');
    }

    // Apps Script بيرد بـ 302 على الموبايل بعد ما يكتب الصف (الكتابة تمت فعلاً).
    if (res.statusCode == 302 || res.statusCode == 303) return;

    if (res.statusCode == 200) {
      try {
        final json = jsonDecode(res.body) as Map<String, dynamic>;
        if (json['ok'] == true) return;
        throw SheetsException(
            (json['error'] ?? 'Submission failed. Please try again.').toString());
      } on FormatException {
        throw SheetsException('Unexpected server response.');
      }
    }
    throw SheetsException('Submission failed (${res.statusCode}).');
  }
}
