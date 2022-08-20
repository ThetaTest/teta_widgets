// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Container Template
String containerCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  var margin = CS.margin(context, body, isMargin: true);
  if (margin == 'margin: EdgeInsets.zero,') margin = '';
  var padding = CS.margin(context, body, isMargin: false);
  if (padding == 'padding: EdgeInsets.zero,') padding = '';
  return '''
    Container(
      $margin
      $padding
      ${CS.size(context, body, isWidth: true)}
      ${CS.size(context, body, isWidth: false)}
      ${CS.boxDecoration(context, body, DBKeys.fill)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
