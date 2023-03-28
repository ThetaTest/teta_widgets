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

/// AspectRatio Template
class AspectRatioCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final aspectRatio = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.double,
    );

    final childString = await CS.child(context, child, comma: true);
    final code = '''
    AspectRatio(
      aspectRatio: $aspectRatio,
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.aspectRatio),
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
    const name = 'AspectRatio';
    final nodeBody = NodeBody.get(NType.aspectRatio);
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
    group('AspectRatio toCode test', () {
      test(
        'AspectRatio: default',
        () {
          final body = NodeBody.get(NType.aspectRatio);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final aspectRatio = abstract.toCode(
            0,
            resultType: ResultTypeEnum.int,
          );
          expect(
            FormatterTest.format('''
             AspectRatio(
              aspectRatio: $aspectRatio,
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
    });
  }
}
