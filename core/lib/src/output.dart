import 'dart:io';

import 'package:core/src/service/environment_service.dart';

/// This file provides methods for handling various output related operations.
///
/// For detailed information on GitHub Actions workflow commands, refer to
/// [GitHub Actions Documentation](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions).

/// Output [value] under the variable [name] when the step is complete.
///
/// This makes the output variables available to be mapped into inputs of other
/// actions to ensure they are decoupled.
void setOutput(String name, String value) {
  // Set variable in the Github env file for future actions
  String filepath =
      environmentService.getEnvironmentVariable("GITHUB_OUTPUT") ?? "";
  var sink = File(filepath).openWrite();
  sink.write('$name=$value\n');
  sink.close();
}
