// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for FadeInAnimation widget
class FadeInCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    FadeInAnimation(
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.fadeInAnimation),
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
    const name = 'FadeInAnimation';
    final nodeBody = NodeBody.get(NType.fadeInAnimation);
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
    group('FadeInAnimation toCode test', () {
      test(
        'FadeInAnimation: default',
        () {
          expect(
            FormatterTest.format('''
            FadeInAnimation(
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
    });
  }
}
