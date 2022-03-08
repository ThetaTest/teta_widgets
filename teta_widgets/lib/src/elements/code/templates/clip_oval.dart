// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// ClipOval Template
String clipOvalCodeTemplate(
  final BuildContext context,
  final CNode node,
  final CNode? child,
) {
  return '''
    ClipOval(
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
