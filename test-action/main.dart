import '../core/lib/core.dart' as core;

Future<void> main(List<String> arguments) async {
  core.group("Message tests", () => PrintTests());
  core.group("Input tests", () => InputTests());
}

void PrintTests() {
  core.debug("Debug!");
  core.info("Info!");
  core.error("Error!");
  core.notice("Notice!");
  core.warning("Warning!");
}

void InputTests() {
  String value = core.getInput("test-input");
  core.info("The value of test-input is $value");
  bool booleanValue = core.getBooleanInput("test-input-boolean");
  core.info("The value of test-input-boolean is $booleanValue");
  List<String> multilineValue = core.getMultilineInput("test-input-multiline");
  core.info("The value of test-input-multiline is $multilineValue");
}
