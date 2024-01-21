import 'package:core/src/core/print_service.dart';
import 'package:test/test.dart';
import 'package:core/core.dart' as core;
import 'fakes/fake_ioSink.dart';

void main() {
  group('Core tests:', () {
    late PrintService printService;
    late FakeIOSink fakeIOSink;
    setUp(() {
      fakeIOSink = FakeIOSink();
      printService = PrintService(fakeIOSink);
      core.injectPrintService(printService);
    });

    group('core.info', () {
      test('Sends a message', () {
        core.info("Hello");
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "Hello");
      });
    });

    group('core.debug', () {
      test('Sends a message', () {
        core.debug("Hello");
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::debug::Hello");
      });
    });

    group('core.notice', () {
      test('Sends a message', () {
        core.notice("Hello");
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::notice::Hello");
      });
    });

    group('core.warning', () {
      test('Sends a message', () {
        core.warning("Hello");
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::warning::Hello");
      });
    });

    group('core.error', () {
      test('Sends a message', () {
        core.error("Hello");
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::error::Hello");
      });

      test('Sends a message with annotation properties', () {
        core.error("Hello",
            properties: core.AnnotationProperties(
                file: "file.txt",
                col: 1,
                endColumn: 20,
                line: 1,
                endLine: 2,
                title: "MY TITLE"));
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0],
            "::error title=MY TITLE,file=file.txt,col=1,endColumn=20,line=1,endLine=2::Hello");
      });
    });

    group('core.startGroup', () {
      test('Starts a group', () {
        core.startGroup("Hello");
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::group::Hello");
      });
    });

    group('core.endGroup', () {
      test('Ends a group', () {
        core.endGroup();
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::endgroup::");
      });
    });

    group('core.group', () {
      test('Starts a group and then ends a group', () {
        core.group("Hello", () {
          return;
        });
        expect(fakeIOSink.outputs.length, 2);
        expect(fakeIOSink.outputs[0], "::group::Hello");
        expect(fakeIOSink.outputs[1], "::endgroup::");
      });

      test('Starts a group, runs a function and then ends a group', () {
        core.group("Hello", () {
          core.info("This is my inside function");
        });
        expect(fakeIOSink.outputs.length, 3);
        expect(fakeIOSink.outputs[0], "::group::Hello");
        expect(fakeIOSink.outputs[1], "This is my inside function");
        expect(fakeIOSink.outputs[2], "::endgroup::");
      });
    });
  });
}
