// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for Wrap widget
class WrapCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
  ) async {
    final childrenString = await CS.children(context, children);
    final code = '''
    Wrap(
      $childrenString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final defaultCode = await toCode(
        context,
        NodeBody.get(NType.wrap),
        [],
      );
      return defaultCode;
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'Wrap';
    final nodeBody = NodeBody.get(NType.wrap);
    final codeToRun = await toCode(
      context,
      nodeBody,
      [],
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
    group('Wrap toCode test', () {
      test(
        'Wrap: default code',
        () {
          expect(
            FormatterTest.format('''
            Wrap(
              childrens: []
            )'''),
            true,
          );
        },
      );
    });
  }
}
