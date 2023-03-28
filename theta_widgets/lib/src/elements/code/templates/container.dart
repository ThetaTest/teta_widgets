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

/// Container Template
class ContainerCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    var margin = CS.margin(context, body, isMargin: true);
    if (margin == 'margin: EdgeInsets.zero,') margin = '';
    var padding = CS.margin(context, body, isMargin: false);
    if (padding == 'padding: EdgeInsets.zero,') padding = '';
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Container(
      $margin
      $padding
      ${CS.size(context, body, isWidth: true)}
      ${CS.size(context, body, isWidth: false)}
      ${CS.boxDecoration(context, body, DBKeys.fill)}
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.container),
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
    const name = 'Container';
    final nodeBody = NodeBody.get(NType.container);
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
    group('Container toCode test', () {
      test(
        'Container: fill type none',
        () {
          expect(
            FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.none))}
              ),
              child: const SizedBox(),
            )
            '''),
            true,
          );
        },
      );
      test(
        'Container: fill type solid',
        () {
          expect(
            FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.solid))}
              ),
              child: const SizedBox(),
            )
            '''),
            true,
          );
        },
      );
      test(
        'Container: fill type linear gradient',
        () {
          expect(
            FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.linearGradient))}
              ),
              child: const SizedBox(),
            )
            '''),
            true,
          );
        },
      );
      test(
        'Container: fill type radial gradient',
        () {
          expect(
            FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.radialGradient))}
              ),
              child: const SizedBox(),
            )
            '''),
            true,
          );
        },
      );
      test(
        'Container: fill type image',
        () {
          expect(
            FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.image))}
              ),
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
