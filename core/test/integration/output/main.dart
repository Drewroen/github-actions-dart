import 'package:core/core.dart' as core;

Future<void> main(List<String> arguments) async {
  core.group("Output tests", () => OutputTests());
}

void OutputTests() {
  core.setOutput("TEST_OUTPUT", "OUTPUT SUCCESSFUL");
}
