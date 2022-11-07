import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Visibility widget
class VisibilityCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final visibility = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.bool,
      defaultValue: 'true',
    );

    if (abstract.type == FTextTypeEnum.text && abstract.value == 'true') {
      final code = await CS.child(
        context,
        child,
        comma: false,
        withChild: false,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }

    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Visibility(
      visible: $visibility,
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final defaultCode = await toCode(
        context,
        NodeBody.get(NType.visibility),
        null,
        0,
      );
      return defaultCode;
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'Visibility';
    final nodeBody = NodeBody.get(NType.visibility);
    final codeToRun = await toCode(
      context,
      nodeBody,
      null,
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
    group('Visibility toCode test', () {
      test(
        'Visibility: default code',
        () {
          final body = NodeBody.get(NType.visibility);
          body.attributes[DBKeys.value] = FTextTypeInput(value: 'false');
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final defaultValue = abstract.toCode(
            0,
            resultType: ResultTypeEnum.bool,
          );
          expect(
            FormatterTest.format('''
            Visibility(
             visible: $defaultValue,
             child: const SizedBox(),
            )
            '''),
            true,
          );
        },
      );
    });
  }
}
