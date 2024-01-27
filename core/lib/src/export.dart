import 'dart:io';

import 'package:core/src/service/environment_service.dart';

/// This file provides methods for handling various export related operations.
///
/// For detailed information on GitHub Actions workflow commands, refer to
/// [GitHub Actions Documentation](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions).

/// Sets the environment variable [name] to [value].
///
/// This can be used within the current action, as well as for any actions
/// that follow.
void exportVariable(String name, String value) {
  // Set variable in local environment for the remainder of this action
  environmentService.setEnvironmentVariable(name, value);

  // Set variable in the Github env file for future actions
  String filepath =
      environmentService.getEnvironmentVariable("GITHUB_ENV") ?? "";
  var sink = File(filepath).openWrite();
  sink.write('$name=$value\n');
  sink.close();
}
