import 'dart:io';

import 'package:meta/meta.dart';

EnvironmentService environmentService = EnvironmentService();

@visibleForTesting
void injectEnvironmentService(EnvironmentService _environmentService) =>
    environmentService = _environmentService;

class EnvironmentService {
  late Map<String, String> environment;

  EnvironmentService([Map<String, String>? env]) {
    // Since Platform.environment isn't directly modifiable, get a shallow
    // copy and modify that, and get all environment variables through this
    // service.
    environment = env ?? new Map<String, String>.from(Platform.environment);
  }

  void setEnvironmentVariable(String key, String value) =>
      environment[key] = value;

  String? getEnvironmentVariable(String key) => environment[key];
}
