// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String paddingCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  final padding = CS.margin(context, body, isMargin: false);
  if (padding == '' && CS.child(context, child, comma: true) == '') {
    return '';
  }
  return '''
    Padding(
      ${padding != '' ? padding : "padding: EdgeInsets.zero,"}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
