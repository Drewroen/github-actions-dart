import 'dart:io';

class PrintService {
  late IOSink out;

  PrintService([IOSink? ioSink]) {
    ioSink == null ? this.out = stdout : this.out = ioSink;
  }

  void writeln(String message) {
    out.writeln(message);
  }
}
