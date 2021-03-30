// Reference:
// https://medium.com/flutter-community/a-guide-to-setting-up-better-logging-in-flutter-3db8bab2000e

import 'package:logger/logger.dart';

class SimpleLogger extends Logger {
  final String className;
  SimpleLogger(this.className);

  @override
  void log(Level level, dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    // // Set level for all logging that uses this class
    Logger.level = Level.nothing;

    var color = PrettyPrinter.levelColors[level];
    var emoji = PrettyPrinter.levelEmojis[level];
    var divider = PrettyPrinter.doubleDivider;
    var vertLine = PrettyPrinter.verticalLine;

    print(color!('$divider' * (100)));
    print(color('$vertLine $emoji [$className] $message'));
    if (error != null) {
      print(color('$vertLine\t $error'));
    }
    print(color('$divider' * (100)));
  }
}

Logger getLogger(String className) {
  return SimpleLogger(className);
}
