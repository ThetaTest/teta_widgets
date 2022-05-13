// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for SlideAnimation widget
String slideCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  return '''
    SlideAnimation(
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
