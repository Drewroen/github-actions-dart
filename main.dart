import 'package:core/src/core/input.dart';

import 'lib/core.dart' as core;

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
  core.startGroup("Group!");
  core.info("Info within group!");
  core.endGroup();
}

void InputTests() {
  String value = getInput("test-input");
  core.info("The value of test-input is $value");
}
