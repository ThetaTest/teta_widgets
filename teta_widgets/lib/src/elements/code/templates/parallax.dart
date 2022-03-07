// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// SizedBox Template
String parallaxCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
) {
  final mainAxisExtent = CS
      .size(context, body, isWidth: false)
      .replaceFirst('height:', 'mainAxisExtent:');
  return '''
    Parallax.inside(
      $mainAxisExtent
      ${CS.size(context, body, isWidth: false)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
