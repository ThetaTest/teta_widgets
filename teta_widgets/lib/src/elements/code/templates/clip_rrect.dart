// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// ClipRRect Template
String clipRRectCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
) {
  return '''
    ClipRRect(
      ${CS.borderRadius(context, body)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
