// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Align widget
String alignCodeTemplate(BuildContext context, NodeBody body, CNode? child) {
  return '''
    Align(
      ${CS.align(context, body)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
