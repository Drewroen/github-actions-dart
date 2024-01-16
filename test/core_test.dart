import 'package:test/test.dart';
import 'package:core/core.dart' as core;
import 'fakes/fake_print_service.dart';

void main() {
  group('Empty tests', () {
    late FakePrintService fakePrintService;
    setUp(() {
      fakePrintService = FakePrintService();
      core.injectPrintService(fakePrintService);
    });

    test('Sends an info message', () {
      core.info("Hello");
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "Hello");
    });

    test('Sends a debug message', () {
      core.debug("Hello");
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "::debug::Hello");
    });

    test('Sends a notice message', () {
      core.notice("Hello");
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "::notice::Hello");
    });

    test('Sends a warning message', () {
      core.warning("Hello");
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "::warning::Hello");
    });

    test('Sends an error message', () {
      core.error("Hello");
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "::error::Hello");
    });

    test('Sends a message that starts a group', () {
      core.startGroup("Hello");
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "::group::Hello");
    });

    test('Sends a message that ends a group', () {
      core.endGroup();
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "::endgroup::");
    });

    test('Sends a message within a group', () {
      core.group("Hello", () => {core.info("Hello2")});
      expect(fakePrintService.outputs.length, 3);
      expect(fakePrintService.outputs[0], "::group::Hello");
      expect(fakePrintService.outputs[1], "Hello2");
      expect(fakePrintService.outputs[2], "::endgroup::");
    });
  });
}
