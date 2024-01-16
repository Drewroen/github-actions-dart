import 'package:core/src/core/print_service.dart';

class FakePrintService implements PrintService {
  List<String> outputs = [];

  void writeln(String message) {
    outputs.add(message);
  }
}