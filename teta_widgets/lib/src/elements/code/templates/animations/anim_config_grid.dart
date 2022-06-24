// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for ScaleAnimation widget
String animConfigGridCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int loop,
) {
  final position =
      (body.attributes[DBKeys.value] as FTextTypeInput).toCode(loop);
  final duration =
      (body.attributes[DBKeys.value] as FTextTypeInput).toCode(loop);
  final numCols =
      (body.attributes[DBKeys.valueOfCondition] as FTextTypeInput).toCode(loop);
  return '''
    AnimationConfiguration.staggeredGrid(
      columnCount: int.tryParse(
          $numCols
          ) ??
          2,
      position: int.tryParse(
          $position
          ) ??
          0,
      duration: Duration(
        milliseconds: int.tryParse(
          $duration
          ) ??
          375,
      ),
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
