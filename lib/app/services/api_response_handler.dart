// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import '../config/app_routes.dart';
// import '../customWidgets/custom_dialogs/no_internetdialog.dart';
// import '../mvvm/model/api_response_model/api_response.dart';
// import 'json_extractor.dart';
// import 'logger_service.dart';

// /// Handles API responses with standardized processing.
// class ApiResponseHandler {
//   static Future<ApiResponse<T>> process<T>(
//     dynamic response,
//     String? endPoint,
//     T Function(dynamic dataJson) fromJson,
//   ) async {
//     MessageExtractor().extractAndStoreMessage(endPoint ?? '', response.body);

//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         final parsedJson = response.body.length > 100000
//             ? await compute<String, dynamic>(_parseJson, response.body)
//             : jsonDecode(response.body);
//         LoggerService.i('✅ API response processed: "endPoint"');
//         return ApiResponse<T>.fromJson(parsedJson, fromJson);

//       case 401:
//         _handleUnauthorized(endPoint);
//         break;

//       case 422:
//         return _handleError<T>(response, 'Validation Error');

//       case 500:
//         return _handleError<T>(response, 'Internal Server Error');

//       case 503:
//         return _handleNoInternet();

//       default:
//         return _handleError<T>(
//           response,
//           'API Error: "{response.statusCode} - {response.reasonPhrase}"',
//         );
//     }

//     return ApiResponse<T>(message: 'Unexpected error occurred');
//   }

//   static dynamic _parseJson(String responseBody) {
//     return jsonDecode(responseBody);
//   }

//   static void _handleUnauthorized(String? endPoint) {
//     LoggerService.w('⛔ Unauthorized. Checking endpoint...');

//     if ((endPoint ?? '').toLowerCase().contains('login') ||
//         (endPoint ?? '').toLowerCase().contains('delete-account')) {
//       LoggerService.w('🔁 401 on login endpoint. Skipping redirect.');
//       return;
//     }

//     LoggerService.w('⛔ Unauthorized. Redirecting to login.');
//     // Get.offAllNamed(AppRoutes.loginView);
//     throw Exception('Unauthorized access. Please log in.');
//   }

//   static _handleNoInternet() {
//     LoggerService.w('📴 No internet detected (503)');
//     if (!(Get.isDialogOpen ?? false)) {
//       Future.delayed(Duration.zero, () {
//         NoInternetDialog.show(
//           title: "Network Error",
//           message:
//               "Unable to connect to the server. Please check your internet connection and try again.",
//           closeText: "Dismiss",
//           onClose: () {},
//         );
//       });
//       throw Exception('No internet connection. Please try again.');
//     }
//   }

//   static ApiResponse<T> _handleError<T>(dynamic response, String errorMessage) {
//     try {
//       final errorResponse = jsonDecode(response.body);
//       final message =
//           errorResponse['message'] ?? 'Something went wrong. Please try again.';
//       return ApiResponse<T>(message: message);
//     } catch (e, stack) {
//       LoggerService.e('❌ Error parsing error response',
//           error: e, stackTrace: stack);
//       return ApiResponse<T>(message: errorMessage);
//     }
//   }

//   static void logUnhandledError(dynamic e, StackTrace stackTrace) {
//     LoggerService.e('⚠️ Unhandled error', error: e, stackTrace: stackTrace);
//   }
// }
