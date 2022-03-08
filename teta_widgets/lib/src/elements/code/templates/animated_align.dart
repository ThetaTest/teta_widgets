// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for AnimatedAlign widget
String animatedAlignCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
  int? loop,
) {
  final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final duration = int.tryParse(value) != null ? int.parse(value) : '400';
  return '''
    AnimatedAlign(
      duration: const Duration(milliseconds: $duration),
      ${CS.align(context, body)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
