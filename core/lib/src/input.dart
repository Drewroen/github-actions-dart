/// This file provides methods for handling various input related operations.
///
/// For detailed information on GitHub Actions workflow commands, refer to
/// [GitHub Actions Documentation](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions).

import 'dart:io';

import 'package:core/core.dart';
import 'package:meta/meta.dart';

EnvironmentService _environmentService =
    EnvironmentService(Platform.environment);

@visibleForTesting
void injectEnvironmentVariables(EnvironmentService environmentService) =>
    _environmentService = environmentService;

final List<String> TRUE_VALUES = ['true', 'True', 'TRUE'];
final List<String> FALSE_VALUES = ['false', 'False', 'FALSE'];

/// Retrieves the environment variable [name].
///
/// The value can be trimmed using [options.trimWhitespace]. Throws
/// [ArgumentError] if the value doesn't exist and is [options.required].
String getInput(String name,
    {InputOptions options = const InputOptions.empty()}) {
  String value = _environmentService
          .getEnvironmentVariable('INPUT_${name.toUpperCase()}') ??
      '';
  if (options.required == true && value == '')
    throw ArgumentError(
        "Value for $name does not exist, but is marked required.");
  if (options.trimWhitespace == true) value = value.trim();
  return value;
}

/// Retrieves the boolean environment variable [name].
///
/// Throws [ArgumentError] if the value doesn't exist and is [options.required]
/// or if the value is not a boolean representation, seen in [TRUE_VALUES] or
/// [FALSE_VALUES].
bool getBooleanInput(String name,
    {InputOptions options = const InputOptions.empty()}) {
  String value = getInput(name, options: options);
  if (TRUE_VALUES.contains(value)) {
    return true;
  }
  if (FALSE_VALUES.contains(value)) {
    return false;
  }
  throw ArgumentError(
      "Invalid value. The input value: ($value) must be true or false in one of the following forms: ${[
    TRUE_VALUES.join(','),
    FALSE_VALUES.join(',')
  ].join(',')}");
}

/// Retrieves the multiline environment variable [name].
///
/// The value is returned as a list of strings separated by newlines. The values
/// can be trimmed using [options.trimWhitespace]. Throws [ArgumentError] if the
/// value doesn't exist and is [options.required].
List<String> getMultilineInput(String name,
    {InputOptions options = const InputOptions.empty()}) {
  String value = getInput(name, options: options);

  List<String> response = value.split("\n");

  response = response.where((line) => (line != "")).toList();

  if (options.trimWhitespace)
    response = response.map((line) => line.trim()).toList();

  return response;
}

class InputOptions {
  final bool required;
  final bool trimWhitespace;

  const InputOptions({this.required = false, this.trimWhitespace = false});

  const factory InputOptions.empty() = InputOptions;
}
