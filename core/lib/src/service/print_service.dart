import 'dart:io';

import 'package:meta/meta.dart';

PrintService printService = PrintService(stdout);

@visibleForTesting
void injectPrintService(PrintService _printService) =>
    printService = _printService;

class PrintService {
  late IOSink out;

  PrintService([IOSink? ioSink]) {
    ioSink == null ? this.out = stdout : this.out = ioSink;
  }

  void writeln(String message) {
    out.writeln(message);
  }
}
