// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Column Widget
class ColumnCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
  ) async {
    final childrenString = await CS.children(context, children);
    final code = '''
    Column(
      ${CS.mainAxisAlignment(context, body)}
      ${CS.mainAxisSize(context, body)}
      ${CS.crossAxisAlignment(context, body)}
      $childrenString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.column),
        [],
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'Column(children: [])';
      }
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'Column';
    final nodeBody = NodeBody.get(NType.column);
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
    group('Column toCode test', () {
      test(
        'Column: default',
        () {
          expect(
            FormatterTest.format('''
              Column(children: [])
              '''),
            true,
          );
        },
      );
    });
  }
}
