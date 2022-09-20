// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for TCard widget
class TCardCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final int pageId,
    final CNode node,
    final List<CNode> children,
    final int? loop,
  ) async {
    final slideSpeed =
        (node.body.attributes[DBKeys.value] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '20',
    );
    final delaySlideFor =
        (node.body.attributes[DBKeys.valueOfCondition] as FTextTypeInput)
            .toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '500',
    );
    final lockYAxis = node.body.attributes[DBKeys.flag] as bool? ?? false;
    final childrenString = await CS.children(context, children);
    final code = '''
  TCard(
    onForward: (index, info) async {
      if ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.swipeRight,
      '(info.direction == SwipDirection.Right)',
      null,
      loop: loop,
      isRequired: true,
      endsWithComma: false,
    )}
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.swipeLeft,
      'else',
      null,
      loop: loop,
      isRequired: true,
      endsWithComma: false,
    )}
    },
    lockYAxis: $lockYAxis,
    slideSpeed: $slideSpeed,
    delaySlideFor: $delaySlideFor,
    ${childrenString.replaceFirst('children', 'cards')}
  )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        pageId,
        node,
        [],
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
    group('TCard toCode test', () {
      test(
        'TCard: default',
        () {
          final body = NodeBody.get(NType.tcard);
          final slideSpeed = double.tryParse(
                (body.attributes[DBKeys.value] as FTextTypeInput).toCode(0),
              ) ??
              20;
          final delaySlideFor = double.tryParse(
                (body.attributes[DBKeys.valueOfCondition] as FTextTypeInput)
                    .toCode(0),
              ) ??
              500;
          final lockYAxis = body.attributes[DBKeys.flag] as bool? ?? false;
          const childrenString = 'cards: [],';
          expect(
            FormatterTest.format('''
            TCard(
               onForward: (index, info) async {
                 if(info.direction == SwipDirection.right) {

                 } else{

                 }
               },
             lockYAxis: $lockYAxis,
             slideSpeed: $slideSpeed,
             delaySlideFor: $delaySlideFor,
             $childrenString
             )
            '''),
            true,
          );
        },
      );
    });
  }
}
