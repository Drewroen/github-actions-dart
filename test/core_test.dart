import 'package:core/src/core/print_service.dart';
import 'package:test/test.dart';
import 'package:core/core.dart' as core;
import 'fakes/fake_ioSink.dart';

void main() {
  group('Empty tests', () {
    late PrintService printService;
    late FakeIOSink fakeIOSink;
    setUp(() {
      fakeIOSink = FakeIOSink();
      printService = PrintService(fakeIOSink);
      core.injectPrintService(printService);
    });

    test('Sends an info message', () {
      core.info("Hello");
      expect(fakeIOSink.outputs.length, 1);
      expect(fakeIOSink.outputs[0], "Hello");
    });

    test('Sends a debug message', () {
      core.debug("Hello");
      expect(fakeIOSink.outputs.length, 1);
      expect(fakeIOSink.outputs[0], "::debug::Hello");
    });

    test('Sends a notice message', () {
      core.notice("Hello");
      expect(fakeIOSink.outputs.length, 1);
      expect(fakeIOSink.outputs[0], "::notice::Hello");
    });

    test('Sends a warning message', () {
      core.warning("Hello");
      expect(fakeIOSink.outputs.length, 1);
      expect(fakeIOSink.outputs[0], "::warning::Hello");
    });

    test('Sends an error message', () {
      core.error("Hello");
      expect(fakeIOSink.outputs.length, 1);
      expect(fakeIOSink.outputs[0], "::error::Hello");
    });

    test('Sends an error message with annotation properties', () {
      core.error("Hello",
          properties: core.AnnotationProperties(file: "file.txt", line: 1));
      expect(fakeIOSink.outputs.length, 1);
      expect(fakeIOSink.outputs[0], "::error file=file.txt,line=1::Hello");
    });

    test('Sends a message that starts a group', () {
      core.startGroup("Hello");
      expect(fakeIOSink.outputs.length, 1);
      expect(fakeIOSink.outputs[0], "::group::Hello");
    });

    test('Sends a message that ends a group', () {
      core.endGroup();
      expect(fakeIOSink.outputs.length, 1);
      expect(fakeIOSink.outputs[0], "::endgroup::");
    });

    test('Sends a message within a group', () {
      core.group("Hello", () => {core.info("Hello2")});
      expect(fakeIOSink.outputs.length, 3);
      expect(fakeIOSink.outputs[0], "::group::Hello");
      expect(fakeIOSink.outputs[1], "Hello2");
      expect(fakeIOSink.outputs[2], "::endgroup::");
    });
  });
}
