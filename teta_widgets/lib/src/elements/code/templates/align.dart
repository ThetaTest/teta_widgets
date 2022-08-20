// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Align widget
String alignCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  final align = CS.align(context, body);
  if (align.isEmpty) {
    return CS.child(
      context,
      child,
      comma: false,
      withChild: false,
    );
  }
  return '''
    Align(
      ${CS.align(context, body)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
