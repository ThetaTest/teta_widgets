// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// SizedBox Template
String sizedBoxCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
) {
  return '''
    SizedBox(
      ${CS.size(context, body, isWidth: true)}
      ${CS.size(context, body, isWidth: false)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
