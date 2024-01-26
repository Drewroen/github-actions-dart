import 'dart:io';

class EnvironmentService {
  late Map<String, String> environment;

  EnvironmentService([Map<String, String>? env]) {
    environment = env ?? Platform.environment;
  }

  void setEnvironmentVariable(String key, String value) =>
      environment[key] = value;

  String? getEnvironmentVariable(String key) => environment[key];
}
