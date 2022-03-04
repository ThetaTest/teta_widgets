// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String appBarCodeTemplate(BuildContext context, NodeBody body, CNode? child) {
  return '''
    ${CS.child(context, child, comma: false).replaceFirst('child:', '')}
  ''';
}
