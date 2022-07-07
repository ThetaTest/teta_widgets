// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for ListView widget
///
/// Returns:
/// ```dart
/// ListView(
///   scrollDirection: Axis.horizontal, // isVertical (vertical is dedundant)
///   children: [], // node's children
/// );
/// ```
String listViewCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
) {
  final reverse = body.attributes[DBKeys.isFullWidth] as bool;
  final primary = body.attributes[DBKeys.isPrimary] as bool;
  final _scrollDirection =
      !(body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : '';
  return '''
    ListView(
      reverse: $reverse,
      primary: $primary,
      physics: ${CS.physic(context, body)},
      $_scrollDirection
      ${CS.children(context, children)}
    )
  ''';
}
