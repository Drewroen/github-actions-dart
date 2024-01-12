import 'dart:io';

void debug(String message) {
  stdout.writeln("::debug::$message");
}

void info(String message) {
  stdout.writeln(message);
}

void error(String message,
    [AnnotationProperties parameters = const AnnotationProperties.empty()]) {
  String output = "::error";
  output += parameters.toString();
  output += "::$message";
  stdout.writeln(output);
}

void notice(String message,
    [AnnotationProperties parameters = const AnnotationProperties.empty()]) {
  String output = "::notice";
  output += parameters.toString();
  output += "::$message";
  stdout.writeln(output);
}

void warning(String message,
    [AnnotationProperties parameters = const AnnotationProperties.empty()]) {
  String output = "::warning";
  output += parameters.toString();
  output += "::$message";
  stdout.writeln(output);
}

void startGroup(String name) {
  stdout.writeln("::group::$name");
}

void endGroup() {
  stdout.writeln("::endgroup::");
}

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
