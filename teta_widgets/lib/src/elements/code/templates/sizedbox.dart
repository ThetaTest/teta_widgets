// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// SizedBox Template
String sizedBoxCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  final width = CS.size(context, body, isWidth: true);
  final height = CS.size(context, body, isWidth: false);
  if (width.isEmpty && height.isEmpty) {
    return CS.child(
      context,
      child,
      comma: false,
      withChild: false,
    );
  }
  return '''
    SizedBox(
      $width
      $height
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
