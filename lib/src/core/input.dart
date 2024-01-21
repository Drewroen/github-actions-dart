import 'dart:io';

/// This package covers different methods related to Github inputs
///
/// For more information, see
/// https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions

getInput(String name) {
  Map<String, String> envVars = Platform.environment;
  return envVars['INPUT_${name.toUpperCase()}'] ?? '';
}
