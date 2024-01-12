import 'lib/src/core.dart' as core;

Future<void> main(List<String> arguments) async {
  core.debug("Debug!");
  core.error("Error!");
  core.notice("Notice!");
  core.warning("Warning!");
  core.group("Group!", () => GroupPrint());
}

void GroupPrint() {
  core.debug("1");
  core.debug("2");
}
