/// Generic API response model for flexible data parsing.
class ApiResponse<T> {
  final bool? success;
  final String? message;
  final int? code;
  final T? data;
  final String? token;

  ApiResponse({this.success, this.message, this.code, this.data, this.token});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    final status = json['status'];
    final success = json['success'];
    final isSuccess = success == true || status == 'success';

    final skipKeys = {'status', 'success', 'code', 'error', 'message', 'token'};
    dynamic extractedData;

    if (json['data'] != null) {
      extractedData = json['data'];
    } else {
      for (final entry in json.entries) {
        if (!skipKeys.contains(entry.key) &&
            (entry.value is Map<String, dynamic> || entry.value is List)) {
          extractedData = entry.value;
          break;
        }
      }
    }

    return ApiResponse(
      success: isSuccess,
      message: json['message'] as String?,
      code: json['code'] as int?,
      data: extractedData != null ? fromJsonT(extractedData) : null,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'success': success,
      'message': message,
      'code': code,
      'data': data != null ? toJsonT(data as T) : null,
      'token': token,
    };
  }
}
