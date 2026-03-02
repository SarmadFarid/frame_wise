import 'dart:convert';
import 'package:logger/logger.dart';
import 'global_variables.dart';

class MessageExtractor {
  final Logger _logger = Logger();

  void extractAndStoreMessage(String endPoint, String responseBody) {
    GlobalVariables.errorMessages.clear();

    try {
      _logger.i("💡 API EndPoint: $endPoint - Raw Response: $responseBody");

      final dynamic decoded = jsonDecode(responseBody);

      if (decoded is! Map<String, dynamic>) {
        GlobalVariables.errorMessages.add("Unexpected server response format.");
        return;
      }

      final jsonMap = decoded;

      if (jsonMap['errors'] is Map<String, dynamic>) {
        final errorsMap = jsonMap['errors'] as Map<String, dynamic>;
        for (final entry in errorsMap.entries) {
          final value = entry.value;
          if (value is List) {
            for (final msg in value) {
              if (msg != null && msg.toString().trim().isNotEmpty) {
                GlobalVariables.errorMessages.add(msg.toString().trim());
              }
            }
          } else if (value is String && value.trim().isNotEmpty) {
            GlobalVariables.errorMessages.add(value.trim());
          }
        }
      } else if (jsonMap['errors'] is List) {
        final errorsList = jsonMap['errors'] as List;
        for (final error in errorsList) {
          if (error != null && error.toString().trim().isNotEmpty) {
            GlobalVariables.errorMessages.add(error.toString().trim());
          }
        }
      } else if (jsonMap['data'] is List) {
        final dataList = jsonMap['data'] as List;
        for (final error in dataList) {
          if (error != null && error.toString().trim().isNotEmpty) {
            GlobalVariables.errorMessages.add(error.toString().trim());
          }
        }
      }

      if (GlobalVariables.errorMessages.isEmpty &&
          jsonMap['message'] != null &&
          jsonMap['message'].toString().trim().isNotEmpty) {
        GlobalVariables.errorMessages.add(jsonMap['message'].toString().trim());
      }

      if (GlobalVariables.errorMessages.isEmpty) {
        GlobalVariables.errorMessages.add("Something went wrong.");
      }
    } catch (e, st) {
      _logger.e("❌ Error extracting message: $e", error: e, stackTrace: st);
      GlobalVariables.errorMessages.add("Connection issue. Please retry.");
    }

    _logger.i("✅ Extracted Errors: ${GlobalVariables.errorMessages}");
  }
}
