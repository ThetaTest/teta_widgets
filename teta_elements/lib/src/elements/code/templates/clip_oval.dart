// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/nodes/node.dart';

/// ClipOval Template
String clipOvalCodeTemplate(BuildContext context, CNode node, CNode? child) {
  return '''
    ClipOval(
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
