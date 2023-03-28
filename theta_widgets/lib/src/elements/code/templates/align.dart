// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Align widget
class AlignCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final align = CS.align(body);
    if (align.isEmpty) {
      return CS.child(
        context,
        child,
        comma: false,
        withChild: false,
      );
    }
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Align(
      ${CS.align(body)}
      $childString
    )
  ''';
    final result = FormatterTest.format(code);
    if (result) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.align),
        null,
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
    const name = 'Align';
    final nodeBody = NodeBody.get(NType.align);
    final codeToRun = await toCode(
      context,
      nodeBody,
      null,
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
    group('Alignment toCode test', () {
      test(
        'Alignment: null',
        () {
          final body = NodeBody.get(NType.align);
          body.attributes[DBKeys.align] = FAlign(align: null);
          expect(
            FormatterTest.format('''
            Align(
              ${CS.align(body)}
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
      test(
        'Alignment: default',
        () {
          final body = NodeBody.get(NType.align);
          body.attributes[DBKeys.align] = FAlign();

          expect(
            FormatterTest.format('''
            Align(
              ${CS.align(body)}
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
    });
  }
}
