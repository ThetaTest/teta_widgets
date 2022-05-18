// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
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
String tCardBuilderCodeTemplate(
  final BuildContext context,
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
  final childString = child != null ? child.toCode(context) : '';
  final dataset =
      (node.body.attributes[DBKeys.datasetInput] as FDataset).datasetName;
  return '''
  Builder(
    builder: (context) {
      return TCard(
        onForward: (index, info) async {
          if (info.direction == SwipDirection.Right) {
            print('Like');
          } else {
            print('Dislike');
          }
        },
        lockYAxis: $lockYAxis,
        slideSpeed: $slideSpeed,
        delaySlideFor: $delaySlideFor,
        cards: (datasets['$dataset'] as List<dynamic> ?? <dynamic>[]).map((e) => $childString).toList(),
      );
    }
  )
  ''';
}
