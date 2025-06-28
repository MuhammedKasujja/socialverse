import 'package:logger/logger.dart';

class _SystemLogger {
  final Logger _logger = Logger(printer: PrettyPrinter());
  void debug({String? key, dynamic data}) => _logger.d({key: data});
  void info(dynamic message) => _logger.i(message);
  void warning(dynamic message) => _logger.w(message);
  void error(dynamic message, [dynamic error]) =>
      _logger.e(message, error: error, stackTrace: StackTrace.current);
}

final logger = _SystemLogger();
