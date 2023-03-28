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

/// Generates the code for badge widget
class BadgeCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final fill = FFill.toCode(
      body.attributes[DBKeys.fill] as FFill,
      context,
      flagConst: false,
    );
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Badge(
      badgeContent: Text( 
        $value,
        ${CS.textStyle(context, body, DBKeys.textStyle)}
        ),
        ${fill!.replaceAll('color:', 'badgeColor:')}
        $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.badge),
        null,
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
    const name = 'Badge';
    final nodeBody = NodeBody.get(NType.badge);
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
    group('Badge toCode test', () {
      test(
        'Badge: default code',
        () {
          final body = NodeBody.get(NType.badge);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final value = abstract.toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final fill = FFill.toCodeTests(FFill().ready(FFillType.solid));
          expect(
            FormatterTest.format('''
            Badge(
              badgeContent: Text($value,),
              ${fill!.replaceAll('color:', 'badgeColor:')}
              child: const SizedBox(),)
            '''),
            true,
          );
        },
      );
    });
  }
}
