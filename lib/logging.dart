// Reference:
// https://medium.com/flutter-community/a-guide-to-setting-up-better-logging-in-flutter-3db8bab2000e

import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);

  @override
  @override
  void log(Level level, message, error, StackTrace stackTrace) {
    // Set level for all logging that uses this class
    Logger.level = Level.verbose;

    var color = PrettyPrinter.levelColors[level];
    var emoji = PrettyPrinter.levelEmojis[level];
    var divider = PrettyPrinter.doubleDivider;
    var vertLine = PrettyPrinter.verticalLine;

    println(color('$divider' * (100)));
    println(color('$vertLine $emoji $className - $message'));
    println(color('$divider' * (100)));
  }
}

Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}
