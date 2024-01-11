import 'logger.dart';

Future<void> main(List<String> arguments) async {
  Logger logger = Logger();
  logger.debug("Debug!");
  logger.error("Error!", LoggingParameters.empty());
  logger.notice("Notice!", LoggingParameters.empty());
  logger.warning("Warning!", LoggingParameters.empty());
  logger.group("Group!", () => GroupPrint(logger));
}

void GroupPrint(Logger logger) {
  logger.debug("1");
  logger.debug("2");
}
