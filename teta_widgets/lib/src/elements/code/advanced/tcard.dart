// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Generates the code for ListView widget
///
/// Returns:
/// ```dart
/// ListView(
///   scrollDirection: Axis.horizontal, // isVertical (vertical is dedundant)
///   children: [], // node's children
/// );
/// ```
class TCardCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final int pageId,
    final CNode node,
    final List<CNode> children,
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
        loop,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }
  }
}
