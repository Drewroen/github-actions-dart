import 'lib/core.dart' as core;

Future<void> main(List<String> arguments) async {
  core.debug("Debug!");
  core.info("Info!");
  core.error("Error!");
  core.notice("Notice!");
  core.warning("Warning!");
  core.group("Group!", () => GroupPrint());
  core.startGroup("Group2!");
  core.info("This is part of group 2");
  core.endGroup();
}

void GroupPrint() {
  core.info("This is part of group 1");
}
