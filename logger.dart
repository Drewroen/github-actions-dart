import 'dart:collection';
import 'dart:io';

class Logger {
  void debug(String message) {
    stdout.writeln("::debug::$message");
  }

  void error(String message, LoggingParameters parameters) {
    String output = "::error";
    output += parameters.toString();
    output += "::message";
    stdout.writeln(output);
  }

  void notice(String message, LoggingParameters parameters) {
    String output = "::notice";
    output += parameters.toString();
    output += "::message";
    stdout.writeln(output);
  }

  void warning(String message, LoggingParameters parameters) {
    String output = "::warning";
    output += parameters.toString();
    output += "::message";
    stdout.writeln(output);
  }

  void group(String title, Function f) {
    stdout.writeln("::group::$title");
    f();
    stdout.writeln("::endgroup::");
  }
}

class LoggingParameters {
  String? title;
  String? file;
  int? col;
  int? endColumn;
  int? line;
  int? endLine;

  LoggingParameters(
      {this.title,
      this.file,
      this.col,
      this.endColumn,
      this.line,
      this.endLine});

  toString() {
    return "";
  }

  factory LoggingParameters.empty() {
    return LoggingParameters();
  }
}
