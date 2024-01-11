import 'logger.dart';

Future<void> main(List<String> arguments) async {
  Logger logger = Logger();
  logger.debug("Debug!");
  logger.error("Error!");
  logger.notice("Notice!");
  logger.warning("Warning!");
  logger.group("Group!", () => GroupPrint(logger));
}

void GroupPrint(Logger logger) {
  logger.debug("1");
  logger.debug("2");
}
