import 'package:core/core.dart' as core;

Future<void> main(List<String> arguments) async {
  core.group("Input tests", () => InputTests());
}

void InputTests() {
  String value = core.getInput("TEST_INPUT");
  core.info("The value of test-input is $value");
  bool booleanValue = core.getBooleanInput("TEST_INPUT_BOOLEAN");
  core.info("The value of test-input-boolean is $booleanValue");
  List<String> multilineValue = core.getMultilineInput("TEST_INPUT_MULTILINE");
  core.info("The value of test-input-multiline is $multilineValue");
}
