import '../../../../core/lib/core.dart' as core;

Future<void> main(List<String> arguments) async {
  core.group("Message tests", () => PrintTests());
  core.group("Input tests", () => InputTests());
  core.group("Export tests", () => ExportTests());
  core.group("Output tests", () => OutputTests());
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

void ExportTests() {
  core.exportVariable("Test", "123");
}

void OutputTests() {
  core.setOutput("test-output", "OUTPUT SUCCESSFUL!");
}