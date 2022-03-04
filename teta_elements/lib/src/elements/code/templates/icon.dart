// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/features/fill.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String iconCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode node,
  CNode? child,
  int? loop,
) {
  final icon = body.attributes[DBKeys.icon] as String;
  final fill = (body.attributes[DBKeys.fill] as FFill).getHexColor(context);
  return """
    Icon (
      MdiIcons.fromString('''$icon'''),
      ${CS.size(context, body, isWidth: true).replaceAll('width', 'size')}
      color: Color(0xFF$fill),
    )
  """;
}
