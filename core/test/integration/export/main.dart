import 'package:core/core.dart' as core;

Future<void> main(List<String> arguments) async {
  core.group("Export tests", () => ExportTests());
}

void ExportTests() {
  core.exportVariable("Test", "123");
}
