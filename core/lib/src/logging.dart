import 'package:core/src/service/print_service.dart';

/// Prints [message] as a debug message to the log.
///
/// You must create a secret named ACTIONS_STEP_DEBUG with the value true to see
/// the debug messages set by this command in the log.
void debug(String message) {
  printService.writeln("::debug::$message");
}

/// Prints [message] as a (default) info message to the log.
void info(String message) {
  printService.writeln(message);
}

/// Prints [message] as an error message and prints the message to the log.
///
/// This message will create an annotation, which can associate the message with
/// a particular file in your repository. Optionally, your message can specify a
/// position within the file by configuring [parameters].
void error(String message,
    {AnnotationProperties properties = const AnnotationProperties.empty()}) {
  String output = "::error${properties.toString()}::$message";
  printService.writeln(output);
}

/// Prints [message] as a notice message and prints the message to the log.
///
/// This message will create an annotation, which can associate the message with
/// a particular file in your repository. Optionally, your message can specify a
/// position within the file by configuring [parameters].
void notice(String message,
    {AnnotationProperties properties = const AnnotationProperties.empty()}) {
  String output = "::notice${properties.toString()}::$message";
  printService.writeln(output);
}

/// Prints [message] as a warning message and prints the message to the log.
///
/// This message will create an annotation, which can associate the message with
/// a particular file in your repository. Optionally, your message can specify a
/// position within the file by configuring [parameters].
void warning(String message,
    {AnnotationProperties properties = const AnnotationProperties.empty()}) {
  String output = "::warning${properties.toString()}::$message";
  printService.writeln(output);
}

/// Begins an expandable group in the log named [name].
void startGroup(String name) {
  printService.writeln("::group::$name");
}

/// Closes an expandable group in the log.
void endGroup() {
  printService.writeln("::endgroup::");
}

/// Creates an expandable group in the log named [name].
///
/// Function [func] is executed inside the expandable group.
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
    if (_isEmpty()) {
      return "";
    }
    List<String> validAnnotations = [];
    if (title != null) validAnnotations.add("title=$title");
    if (file != null) validAnnotations.add("file=$file");
    if (col != null) validAnnotations.add("col=$col");
    if (endColumn != null) validAnnotations.add("endColumn=$endColumn");
    if (line != null) validAnnotations.add("line=$line");
    if (endLine != null) validAnnotations.add("endLine=$endLine");
    return " " + validAnnotations.join(",");
  }

  bool _isEmpty() {
    if (title != null) return false;
    if (file != null) return false;
    if (col != null) return false;
    if (endColumn != null) return false;
    if (line != null) return false;
    if (endLine != null) return false;
    return true;
  }

  const factory AnnotationProperties.empty() = AnnotationProperties;
}
