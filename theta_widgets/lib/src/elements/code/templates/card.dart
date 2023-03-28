// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Card Template
class CardCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final elevation = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.double,
      defaultValue: '1',
    );
    final fill = FFill.toCode(
      body.attributes[DBKeys.fill] as FFill,
      context,
      flagConst: false,
    );
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Card(
      elevation: $elevation,
      $fill
      ${CS.shapeCardBorderRadius(context, body)}
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.card),
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
    const name = 'Card';
    final nodeBody = NodeBody.get(NType.card);
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
    group('Card toCode test', () {
      test(
        'Card: default code',
        () {
          final body = NodeBody.get(NType.card);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final elevation = abstract.toCode(
            0,
            resultType: ResultTypeEnum.double,
            defaultValue: '1',
          );
          final fill = FFill.toCodeTests(FFill().ready(FFillType.solid));
          expect(
            FormatterTest.format('''
             Card(
      elevation: $elevation,
      $fill
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
