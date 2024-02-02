import 'package:core/core.dart' as core;

Future<void> main(List<String> arguments) async {
  core.group("Logging tests", () => LoggingTests());
}

void LoggingTests() {
  core.debug("Debug!");
  core.info("Info!");
  core.error("Error!");
  core.notice("Notice!");
  core.warning("Warning!");
}
