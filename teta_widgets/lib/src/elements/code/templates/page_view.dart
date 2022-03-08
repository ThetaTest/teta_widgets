// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// PageView Template
String pageViewCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final List<CNode> children,
) {
  final _scrollDirection =
      !(body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : 'scrollDirection: Axis.vertical,';
  return '''
    PageView(
      $_scrollDirection     
      ${CS.children(context, children)}
    )
  ''';
}
