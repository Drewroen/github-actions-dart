/// This package covers different ways to log messages in a Github Action.
///
/// For more information, see
/// https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions
import 'package:meta/meta.dart';

import 'print_service.dart';

PrintService _printService = PrintService();

@visibleForTesting
void injectPrintService(PrintService service) => _printService = service;

/// Prints a debug message to the log.
///
/// You must create a secret named ACTIONS_STEP_DEBUG with the value true to see
/// the debug messages set by this command in the log.
void debug(String message) {
  _printService.writeln("::debug::$message");
}

/// Prints a (default) info message to the log.
void info(String message) {
  _printService.writeln(message);
}

/// Creates an error message and prints the message to the log.
///
/// This message will create an annotation, which can associate the message with
/// a particular file in your repository. Optionally, your message can specify a
/// position within the file by configuring [parameters].
void error(String message,
    [AnnotationProperties parameters = const AnnotationProperties.empty()]) {
  String output = "::error";
  output += parameters.toString();
  output += "::$message";
  _printService.writeln(output);
}

/// Creates a notice message and prints the message to the log.
///
/// This message will create an annotation, which can associate the message with
/// a particular file in your repository. Optionally, your message can specify a
/// position within the file by configuring [parameters].
void notice(String message,
    [AnnotationProperties parameters = const AnnotationProperties.empty()]) {
  String output = "::notice";
  output += parameters.toString();
  output += "::$message";
  _printService.writeln(output);
}

/// Creates a warning message and prints the message to the log.
///
/// This message will create an annotation, which can associate the message with
/// a particular file in your repository. Optionally, your message can specify a
/// position within the file by configuring [parameters].
void warning(String message,
    [AnnotationProperties parameters = const AnnotationProperties.empty()]) {
  String output = "::warning";
  output += parameters.toString();
  output += "::$message";
  _printService.writeln(output);
}

/// Begins an expandable group in the log.
void startGroup(String name) {
  _printService.writeln("::group::$name");
}

/// Closes an expandable group in the log.
void endGroup() {
  _printService.writeln("::endgroup::");
}

/// Creates an expandable group in the log.
///
/// To create a group, use the group command and specify a title. Anything you
/// print to the log between the group and endgroup commands is nested inside an
/// expandable entry in the log.
void group(String name, Function func) {
  startGroup(name);
  func();
  endGroup();
}

class AnnotationProperties {
  final String? title;
  final String? file;
  final int? col;
  final int? endColumn;
  final int? line;
  final int? endLine;

  const AnnotationProperties(
      {this.title,
      this.file,
      this.col,
      this.endColumn,
      this.line,
      this.endLine});

  toString() {
    // TODO(drewroen): Update AnnotationProperties to return the correct string
    return "";
  }

  const factory AnnotationProperties.empty() = AnnotationProperties;
}
