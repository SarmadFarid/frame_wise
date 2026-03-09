import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

/// Custom log printer with enhanced formatting and timestamps.
class CustomPrinter extends LogPrinter {
  final PrettyPrinter _prettyPrinter;

  CustomPrinter()
    : _prettyPrinter = PrettyPrinter(
        methodCount: 1,
        errorMethodCount: 6,
        lineLength: 120,
        colors: true,
        printEmojis: true,
      );

  @override
  List<String> log(LogEvent event) {
    final output = _prettyPrinter.log(event);
    final formattedTime = DateFormat(
      'dd-MM-yyyy hh:mm:ss a',
    ).format(DateTime.now());
    final levelName = event.level.name.toUpperCase();
    return output
        .map((line) => '[📅 $formattedTime] [$levelName] $line')
        .toList();
  }
}

class LoggerService {
  LoggerService._();

  static final Logger _logger = Logger(
    filter: ProductionFilter(),
    printer: CustomPrinter(),
    level: kDebugMode ? Level.trace : Level.warning,
  );

  static void d(dynamic message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(dynamic message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
