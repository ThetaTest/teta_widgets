// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// PageView Template
String pageViewCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode node,
  List<CNode> children,
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
