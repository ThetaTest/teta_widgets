// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';

/// Generates the code for ListView widget
///
/// Returns:
/// ```dart
/// ListView(
///   scrollDirection: Axis.horizontal, // isVertical (vertical is dedundant)
///   children: [], // node's children
/// );
/// ```
String tCardBuilderCodeTemplate(
  final BuildContext context,
  final int pageId,
  final CNode node,
  final CNode? child,
  final int? loop,
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
  final childString =
      child != null ? child.toCode(context) : 'const SizedBox()';
  final dataset =
      (node.body.attributes[DBKeys.datasetInput] as FDataset).datasetName;

  return '''
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
}
