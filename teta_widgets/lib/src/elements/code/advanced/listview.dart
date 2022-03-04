// Flutter imports:
import 'package:flutter/material.dart';
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
  BuildContext context,
  NodeBody body,
  List<CNode> children,
) {
  final primary = body.attributes[DBKeys.isPrimary] as bool;
  final _scrollDirection =
      !(body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : '';
  return '''
    ListView(
      primary: $primary,
      $_scrollDirection
      ${CS.children(context, children)}
    )
  ''';
}

// ignore: unused_element
Widget _example() {
  return ListView(
    // ignore: avoid_redundant_argument_values
    scrollDirection: Axis.vertical, // isVertical (vertical is dedundant!)
    // ignore: avoid_redundant_argument_values
    children: const [], // All children.toCode
  );
}
