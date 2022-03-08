// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// LiquidSwipe Template
String liquidSwipeCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
) {
  return '''
    LiquidSwipe(
      ${CS.pages(context, children)}
    )
  ''';
}
