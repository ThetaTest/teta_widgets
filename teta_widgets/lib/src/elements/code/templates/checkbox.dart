// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Checkbox widget
class CheckBoxCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final int loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    var code = '';
    if (abstract.type == FTextTypeEnum.state ||
        abstract.type == FTextTypeEnum.param) {
      final value = abstract.type == FTextTypeEnum.state
          ? abstract.stateName
          : abstract.paramName;
      code = '''
   StatefulBuilder(
            builder: (final context, final localSetState) {
              return Checkbox(
                value: $value == 'true',
                onChanged: (final bool? b) {
                  localSetState(() {
                    if ($value == 'true') {
                      $value = 'false';
                    } else {
                      $value = 'true';
                    }
                  });
                },
              );
            },
          )
  ''';
    } else if (abstract.type == FTextTypeEnum.text) {
      final val = abstract.toCode(
        loop,
        resultType: ResultTypeEnum.string,
      );
      final value = val == 'true';
      code = '''
Builder(builder: (context) {
          var val = $value;
          return StatefulBuilder(
            builder: (final context, final localSetState) {
              return Checkbox(
                value: val,
                onChanged: (final bool? b) {
                  localSetState(() {
                    val = b!;
                  });
                },
              );
            },
          );
        })
''';
    } else {
      code = '''
Checkbox(
      value: false,
      onChanged: (final bool? b) {
    },
)
''';
    }
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.checkbox),
        0,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'Checkbox';
    final nodeBody = NodeBody.get(NType.checkbox);
    final codeToRun = await toCode(
      context,
      nodeBody,
      0,
    );
    final returnValue = FormatterTest.format(
      codeToRun,
    );
    if (!returnValue) {
      Logger.printError(
        'Runtime ToCode Default Error:\n$name\nThis was the code:\n',
      );
      Logger.printWarning(codeToRun);
      Logger.printMessage('\n-----------END-----------');
    } else {
      Logger.printSuccess('$name: Passed!');
    }
    return returnValue;
  }

  static void testCode() {
    group('CheckBox toCode test', () {
      test(
        'CheckBox: default Value',
        () {
          expect(
            FormatterTest.format('''
            Checkbox(
              value: false,
              onChanged: (final bool? b) {},
            )
            '''),
            true,
          );
        },
      );
      test(
        'CheckBox: text Value',
        () {
          final value = FTextTypeInput(value: 'true').toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format('''
           Builder(builder: (context) {
          var val = $value;
          return StatefulBuilder(
            builder: (final context, final localSetState) {
              return Checkbox(
                value: val,
                onChanged: (final bool? b) {
                  localSetState(() {
                    val = b!;
                  });
                },
              );
            },
          );
        })
            '''),
            true,
          );
        },
      );
    });
  }
}
