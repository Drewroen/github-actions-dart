import 'dart:collection';
import 'dart:io';

class Logger {
  void debug(String message) {
    stdout.writeln("::debug::$message");
  }

  void error(String message,
      [LoggingParameters parameters = const LoggingParameters.empty()]) {
    String output = "::error";
    output += parameters.toString();
    output += "::message";
    stdout.writeln(output);
  }

  void notice(String message,
      [LoggingParameters parameters = const LoggingParameters.empty()]) {
    String output = "::notice";
    output += parameters.toString();
    output += "::message";
    stdout.writeln(output);
  }

  void warning(String message,
      [LoggingParameters parameters = const LoggingParameters.empty()]) {
    String output = "::warning";
    output += parameters.toString();
    output += "::message";
    stdout.writeln(output);
  }

  void group(String title, Function func) {
    stdout.writeln("::group::$title");
    func();
    stdout.writeln("::endgroup::");
  }
}

class LoggingParameters {
  final String? title;
  final String? file;
  final int? col;
  final int? endColumn;
  final int? line;
  final int? endLine;

  const LoggingParameters(
      {this.title,
      this.file,
      this.col,
      this.endColumn,
      this.line,
      this.endLine});

  toString() {
    return "";
  }

  const factory LoggingParameters.empty() = LoggingParameters;
}
