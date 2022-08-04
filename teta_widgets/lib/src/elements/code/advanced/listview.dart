// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';

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
  final NDynamic node,
  final int pageId,
  final List<CNode> children,
  final int? loop,
) {
  final reverse = node.body.attributes[DBKeys.isFullWidth] as bool;
  final primary = node.body.attributes[DBKeys.isPrimary] as bool;
  final _scrollDirection =
      !(node.body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : '';
  return '''
    NotificationListener<ScrollEndNotification>(
          onNotification: (final scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            final isTop = metrics.pixels == 0;
            if ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.scrollToTop,
    '(isTop)',
    null,
    loop: loop,
    isRequired: false,
    endsWithComma: false,
  )}
            ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.scrollToBottom,
    'else',
    null,
    loop: loop,
    isRequired: false,
    endsWithComma: false,
  )}
          }
          return true;
        },
          child: ListView(
        reverse: $reverse,
        primary: $primary,
        physics: ${CS.physic(context, node.body)},
        $_scrollDirection
        ${CS.children(context, children)}
      ),
    )
  ''';
}
