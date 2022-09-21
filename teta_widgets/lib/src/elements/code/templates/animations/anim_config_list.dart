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

/// Generates the code for ConfigListAnimation widget
class AnimConfigListCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int loop,
  ) async {
    final position = (body.attributes[DBKeys.value] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
    );
    final duration =
        (body.attributes[DBKeys.duration] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '375',
    );
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    AnimationConfiguration.staggeredList(
      position: $position,
      duration: Duration(
        milliseconds: $duration,
      ),
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.animationConfigList),
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
    const name = 'AnimationConfigList';
    final nodeBody = NodeBody.get(NType.animationConfigList);
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
    group('animationConfigList toCode test', () {
      test(
        'animationConfigList: default',
        () {
          final body = NodeBody.get(NType.animationConfigList);
          final position =
              (body.attributes[DBKeys.value] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.int,
          );
          final duration =
              (body.attributes[DBKeys.duration] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.int,
            defaultValue: '375',
          );
          expect(
            FormatterTest.format('''
            AnimationConfiguration.staggeredList(
            position: int.tryParse($position  ) ?? 0,
            duration: Duration(milliseconds: int.tryParse($duration) ?? 375),
            child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
    });
  }
}
