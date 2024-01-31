import 'package:core/src/service/environment_service.dart';
import 'package:core/src/service/print_service.dart';
import 'package:test/test.dart';
import 'package:core/core.dart' as core;
import 'fakes/fake_ioSink.dart';

void main() {
  group('Logging tests:', () {
    late PrintService printService;
    late FakeIOSink fakeIOSink;
    setUp(() {
      fakeIOSink = FakeIOSink();
      printService = PrintService(fakeIOSink);
      injectPrintService(printService);
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

      test('Sends a message with title annotation property', () {
        core.error("Hello",
            properties: core.AnnotationProperties(title: "MY TITLE"));
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::error title=MY TITLE::Hello");
      });

      test('Sends a message with file annotation property', () {
        core.error("Hello",
            properties: core.AnnotationProperties(file: "file.txt"));
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::error file=file.txt::Hello");
      });

      test('Sends a message with col annotation property', () {
        core.error("Hello", properties: core.AnnotationProperties(col: 1));
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::error col=1::Hello");
      });

      test('Sends a message with endColumn annotation property', () {
        core.error("Hello",
            properties: core.AnnotationProperties(endColumn: 20));
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::error endColumn=20::Hello");
      });

      test('Sends a message with line annotation property', () {
        core.error("Hello", properties: core.AnnotationProperties(line: 1));
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::error line=1::Hello");
      });

      test('Sends a message with endLine annotation property', () {
        core.error("Hello", properties: core.AnnotationProperties(endLine: 2));
        expect(fakeIOSink.outputs.length, 1);
        expect(fakeIOSink.outputs[0], "::error endLine=2::Hello");
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

  group('Input tests:', () {
    Map<String, String> fakeEnvironmentVariables = {
      "INPUT_STRING": "ABC",
      "INPUT_BOOL_TRUE_1": "TRUE",
      "INPUT_BOOL_TRUE_2": "true",
      "INPUT_BOOL_TRUE_3": "True",
      "INPUT_BOOL_FALSE_1": "FALSE",
      "INPUT_BOOL_FALSE_2": "false",
      "INPUT_BOOL_FALSE_3": "False",
      "INPUT_STRING_MULTILINE": "ABC\nDEF\nGHI\nJKL",
      "INPUT_STRING_MULTILINE_WITH_SPACES":
          "        ABC    \n  DEF   \nGHI   \n    JKL",
    };
    setUp(() {
      injectEnvironmentService(EnvironmentService(fakeEnvironmentVariables));
    });

    group('core.getInput', () {
      test('Gets a value from an environment variable', () {
        String value = core.getInput("STRING");
        expect(value, "ABC");
      });

      test('Returns an empty string if the environment variable is empty', () {
        String value = core.getInput("MISSING_VALUE");
        expect(value, "");
      });

      test(
          'Throws an error if the environment variable is empty and required is true',
          () {
        try {
          core.getInput("MISSING_VALUE",
              options: core.InputOptions(required: true));
        } catch (e) {
          expect(e.runtimeType, ArgumentError);
        }
      });
    });

    group('core.getBooleanInput', () {
      for (int i = 1; i <= 3; i++) {
        test(
            "Returns true when environment variable is ${fakeEnvironmentVariables["INPUT_BOOL_TRUE_$i"]}",
            () {
          bool value = core.getBooleanInput("BOOL_TRUE_$i");
          expect(value, true);
        });

        test(
            "Returns false when environment variable is ${fakeEnvironmentVariables["INPUT_BOOL_FALSE_$i"]}",
            () {
          bool value = core.getBooleanInput("BOOL_FALSE_$i");
          expect(value, false);
        });
      }

      test("Throws an error if the environment variable is empty", () {
        try {
          core.getBooleanInput("MISSING_VALUE");
        } catch (e) {
          expect(e.runtimeType, ArgumentError);
        }
      });
    });

    group('core.getMultilineInput', () {
      test("Returns a list of strings when getting a multiline variable", () {
        List<String> value = core.getMultilineInput("STRING_MULTILINE");
        expect(value.length, 4);
        expect(value.join(","), "ABC,DEF,GHI,JKL");
      });

      test("Returns a list of strings when getting a multiline variable", () {
        List<String> value = core.getMultilineInput(
            "STRING_MULTILINE_WITH_SPACES",
            options: core.InputOptions(trimWhitespace: true));
        expect(value.length, 4);
        expect(value.join(","), "ABC,DEF,GHI,JKL");
      });

      test(
          'Throws an error if the environment variable is empty and required is true',
          () {
        try {
          core.getMultilineInput("MISSING_VALUE",
              options: core.InputOptions(required: true));
        } catch (e) {
          expect(e.runtimeType, ArgumentError);
        }
      });
    });
  });
}
