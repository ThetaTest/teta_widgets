// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Column Template
String columnCodeTemplate(
  BuildContext context,
  NodeBody body,
  List<CNode> children,
) {
  return '''
    Column(
      ${CS.mainAxisAlignment(context, body)}
      ${CS.mainAxisSize(context, body)}
      ${CS.crossAxisAlignment(context, body)}
      ${CS.children(context, children)}
    )
  ''';
}
