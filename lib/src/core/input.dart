/// This package covers different methods related to Github inputs.
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

String getInput(String name, {InputOptions? options}) {
  String value = _environment['INPUT_${name.toUpperCase()}'] ?? '';
  if (options?.required == true && value == '')
    throw ArgumentError(
        "Value for $name does not exist, but is marked required.");
  if (options?.trimWhitespace == true) value = value.trim();
  return value;
}

bool getBooleanInput(String name, {InputOptions? options}) {
  String value = getInput(name);
  if (TRUE_VALUES.contains(value)) return true;
  if (FALSE_VALUES.contains(value)) return false;
  throw ArgumentError(
      "Invalid value. The input value: ($value) must be true or false in one of the following forms: ${[
    TRUE_VALUES.join(','),
    FALSE_VALUES.join(',')
  ].join(',')}");
}

List<String> getMultilineInput(String name, {InputOptions? options}) {
  String value = getInput(name);

  List<String> response = value.split("\n");

  response = response.where((line) => (line != "")).toList();

  if (options != null && options.trimWhitespace!)
    response = response.map((line) => line.trim()).toList();

  return response;
}

class InputOptions {
  bool? required;
  bool? trimWhitespace;

  InputOptions({this.required, this.trimWhitespace});

  factory InputOptions.empty() => InputOptions();
}
