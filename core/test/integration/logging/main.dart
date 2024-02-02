import 'package:core/core.dart' as core;

Future<void> main(List<String> arguments) async {
  core.group("Logging tests", () => LoggingTests());
}

void LoggingTests() {
  const core.AnnotationProperties properties = core.AnnotationProperties(
      title: "TITLE",
      file: "FILE.txt",
      col: 1,
      endColumn: 2,
      line: 1,
      endLine: 1);

  core.debug("This is a debug message.");
  core.info("This is an info message.");
  core.error("This is an error message.", properties: properties);
  core.notice("This is a notice message.", properties: properties);
  core.warning("This is a warning message.", properties: properties);
}
