// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Bouncing widget
class BouncingWidgetCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final CNode? child,
    final int loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final duration = int.tryParse(
          abstract.toCode(
            loop,
            resultType: ResultTypeEnum.int,
            defaultValue: '200',
          ),
        ) ??
        1000;
    final scale = (body.attributes[DBKeys.valueOfCondition] as FTextTypeInput)
        .toCode(loop, resultType: ResultTypeEnum.double, defaultValue: '1');
    final actionString = CS.action(
      pageId,
      context,
      node,
      ActionGesture.onTap,
      'onPressed: () async',
      null,
      isRequired: false,
      loop: loop,
    );
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    BouncingWidget(
      ${actionString != '' ? actionString : 'onPressed: () async {},'}
      duration: const Duration(milliseconds: $duration),
      scaleFactor: $scale,
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        pageId,
        context,
        NodeBody.get(NType.bouncingWidget),
        node,
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

  static void testCode() {
    group('BouncingWidget toCode test', () {
      test(
        'BouncingWidget: default',
        () {
          final body = NodeBody.get(NType.bouncingWidget);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final duration = int.tryParse(
                abstract.toCode(
                  0,
                  resultType: ResultTypeEnum.int,
                  defaultValue: '200',
                ),
              ) ??
              200;
          final scale = (body.attributes[DBKeys.valueOfCondition]
                  as FTextTypeInput)
              .toCode(0, resultType: ResultTypeEnum.double, defaultValue: '1');
          const actionString = 'onPressed: () async{},';
          const childString = 'const SizedBox()';
          expect(
            FormatterTest.format('''
            BouncingWidget(
            ${actionString != '' ? actionString : 'onPressed: () async {},'}
             duration: const Duration(milliseconds: $duration),
             scaleFactor: $scale,
             $childString
             )'''),
            true,
          );
        },
      );
    });
  }
}
