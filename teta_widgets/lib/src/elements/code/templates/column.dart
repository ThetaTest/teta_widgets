// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Column Template
String columnCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
) {
  return '''
    Column(
      ${CS.mainAxisAlignment(context, body)}
      ${CS.mainAxisSize(context, body)}
      ${CS.crossAxisAlignment(context, body)}
      ${CS.children(context, children)}
    )
  ''';
}
