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

    test('Counter value should be incremented', () {
      core.debug("Hello");
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "::debug::Hello");
    });

    test('Counter value should be incremented', () {
      core.notice("Hello");
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "::notice::Hello");
    });
  });
}
