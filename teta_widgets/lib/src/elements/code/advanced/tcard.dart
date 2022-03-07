// Flutter imports:
import 'package:flutter/material.dart';

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
String tCardCodeTemplate(
  BuildContext context,
  CNode node,
  List<CNode> children,
  int? loop,
) {
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
  return '''
  TCard(
    onForward: (index, info) {
      if (info.direction == SwipDirection.Right) {
        //like
        ${CS.action(context, node, ActionGesture.swipeRight, '', null, isRequired: false)}
      } else {
        //dislike
        ${CS.action(context, node, ActionGesture.swipeLeft, '', null, isRequired: false)}
      }
    },
    onEnd: () {
      ${CS.action(context, node, ActionGesture.onEnd, 'onEnd: () async', null, isRequired: false)}
    },
    lockYAxis: $lockYAxis,
    slideSpeed: $slideSpeed,
    delaySlideFor: $delaySlideFor,
    ${CS.children(context, children).replaceFirst('children', 'cards')}
  )
  ''';
}
