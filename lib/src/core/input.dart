/// This package covers different methods related to Github inputs
///
/// For more information, see
/// https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions
import 'dart:io';

import 'package:meta/meta.dart';

Map<String, String> _environment = Platform.environment;

@visibleForTesting
void injectEnvironmentVariables(Map<String, String> environment) =>
    _environment = environment;

final List<String> TRUE_VALUES = ['true', 'True', 'TRUE'];
final List<String> FALSE_VALUES = ['false', 'False', 'FALSE'];

String getInput(String name) {
  return _environment['INPUT_${name.toUpperCase()}'] ?? '';
}

bool getBooleanInput(String name) {
  String value = getInput(name);
  if (TRUE_VALUES.contains(value)) return true;
  if (FALSE_VALUES.contains(value)) return false;
  throw ArgumentError(
      "Invalid argument. Must be true or false in one of the following forms: ${[
    TRUE_VALUES.join(','),
    FALSE_VALUES.join(',')
  ].join(',')}");
}

List<String> getMultilineInput(String name) {
  String value = getInput(name);
  return value.split("\n").where((line) => (line != "")).toList();
}
