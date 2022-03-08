// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for AnimatedOpacity widget
String animatedOpacityCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
  int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final rawDouble = double.tryParse(value.replaceAll('-', '')) != null
      ? double.parse(value.replaceAll('-', ''))
      : 1.0;
  final opacity = rawDouble < 0
      ? 0
      : rawDouble > 1
          ? 1
          : rawDouble;
  final valueDuration =
      (body.attributes[DBKeys.duration] as FTextTypeInput).toCode(loop);
  final duration =
      int.tryParse(valueDuration) != null ? int.parse(valueDuration) : '400';
  return '''
    AnimatedOpacity(
      duration: const Duration(milliseconds: $duration ),
      opacity: $opacity,
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
