// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/fill.dart';
import 'package:theta_widgets/src/elements/nodes/enum.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';

/// CircularProgressIndicator Template
class CircularProgressIndicatorCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final int? loop,
  ) async {
    final fill = FFill.toCode(
      body.attributes[DBKeys.fill] as FFill,
      context,
      flagConst: false,
    );
    final code = '''
    CircularProgressIndicator(
      ${fill!.replaceAll('color:', 'valueColor: AlwaysStoppedAnimation<Color>(')}),
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.circularProgressIndicator),
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
    const name = 'CircularProgressIndicator';
    final nodeBody = NodeBody.get(NType.circularProgressIndicator);
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
    group('Circular Progress Indicator toCode test', () {
      test(
        'Circular Progress Indicator: default code',
        () {
          final fill = FFill.toCodeTests(FFill().ready(FFillType.solid));
          expect(
            FormatterTest.format('''
            CircularProgressIndicator(
             ${fill!.replaceAll('color:', 'valueColor: AlwaysStoppedAnimation<Color>(')}),
            )
            '''),
            true,
          );
        },
      );
    });
  }
}
