import 'dart:convert';
import 'dart:io';

class FakeIOSink implements IOSink {
  @override
  late Encoding encoding;

  List<String> outputs = [];

  @override
  void add(List<int> data) {
    throw UnimplementedError();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    throw UnimplementedError();
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    throw UnimplementedError();
  }

  @override
  Future close() {
    throw UnimplementedError();
  }

  @override
  Future get done => throw UnimplementedError();

  @override
  Future flush() {
    throw UnimplementedError();
  }

  @override
  void write(Object? object) {
    throw UnimplementedError();
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    throw UnimplementedError();
  }

  @override
  void writeCharCode(int charCode) {
    throw UnimplementedError();
  }

  @override
  void writeln([Object? object = ""]) {
    outputs.add(object.toString());
  }
}
