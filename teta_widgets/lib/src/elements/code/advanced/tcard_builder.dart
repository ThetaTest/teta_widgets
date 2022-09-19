// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for TCardBuilder widget
class TCardBuilderCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final int pageId,
    final CNode node,
    final CNode? child,
    final int? loop,
  ) async {
    final slideSpeed = double.tryParse(
          (node.body.attributes[DBKeys.value] as FTextTypeInput).toCode(loop),
        ) ??
        20;
    final delaySlideFor = double.tryParse(
          (node.body.attributes[DBKeys.valueOfCondition] as FTextTypeInput)
              .toCode(loop),
        ) ??
        500;
    final lockYAxis = node.body.attributes[DBKeys.flag] as bool? ?? false;
    final childString =
        child != null ? await child.toCode(context) : 'const SizedBox()';
    final dataset =
        (node.body.attributes[DBKeys.datasetInput] as FDataset).datasetName;

    final code = '''
  Builder(
    builder: (context) {
      return TCard(
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
        cards: (datasets['$dataset'] as List<dynamic>? ?? <dynamic>[]).map((e) => $childString).toList(),
      );
    }
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
    group('TCardBuilder toCode test', () {
      test(
        'TCardBuilder: default',
        () {
          final body = NodeBody.get(NType.tcardBuilder);
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
          expect(
            FormatterTest.format('''
Builder(
    builder: (context) {
            return TCard(
               onForward: (index, info) async {
                 if(info.direction == SwipDirection.right) {

                 } else{

                 }
               },
             lockYAxis: $lockYAxis,
             slideSpeed: $slideSpeed,
             delaySlideFor: $delaySlideFor,
             cards: (datasets['default'] as List<dynamic>? ?? <dynamic>[]).map((e) => const SizedBox()).toList()
             );
            }
          )
            '''),
            true,
          );
        },
      );
    });
  }
}
