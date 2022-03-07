// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// AspectRatio Template
String aspectRatioCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
  int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final aspectRatio =
      double.tryParse(value) != null ? double.parse(value) : '0.5';

  return '''
    AspectRatio(
      aspectRatio: $aspectRatio,
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
