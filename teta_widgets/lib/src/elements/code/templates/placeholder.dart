// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Placeholder Template
String placeholderCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
  int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final strokeWidth =
      double.tryParse(value) != null ? double.parse(value) : 2.0;
  final fill = (body.attributes[DBKeys.fill] as FFill).getHexColor(context);
  return '''
    Placeholder(
      stroke: $strokeWidth,
      color: Color(0xFF$fill),
      ${CS.size(context, body, isWidth: true)}
      ${CS.size(context, body, isWidth: false)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
