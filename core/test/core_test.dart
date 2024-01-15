import 'package:test/test.dart';
import '../core.dart' as core;
import 'fakes/fake_print_service.dart';

void main() {
  group('Empty tests', () {
    FakePrintService fakePrintService = FakePrintService();
    setUp(() {
      core.injectPrintService(fakePrintService);
    });

    test('Counter value should be incremented', () {
      core.debug("Hello");
      expect(fakePrintService.outputs.length, 1);
      expect(fakePrintService.outputs[0], "::debug::Hello");
    });
  });
}
