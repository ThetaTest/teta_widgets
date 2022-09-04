// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';

/// Generates the code for ListView.builder widget
///
/// Returns:
/// ```dart
/// Builder(
///   builder: (context) {
///     final children = <Widget>[]; // node's children
///     return ListView.builder(
///       scrollDirection: Axis.vertical,
///       itemCount: children.length,
///       itemBuilder: (context, index) {
///         return children[index];
///       },
///     );
///   },
/// );
/// ```
Future<String> listViewBuilderCodeTemplate(
  final BuildContext context,
  final NDynamic node,
  final int pageId,
  final CNode? child,
  final int? loop,
) async {
  final _scrollDirection =
      !(node.body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : '';
  final shrinkWrap = node.body.attributes[DBKeys.flag] as bool? ?? false;
  final reverse = node.body.attributes[DBKeys.isFullWidth] as bool;
  final childString =
      child != null ? child.toCode(context) : 'const SizedBox()';
  final dataset =
      (node.body.attributes[DBKeys.datasetInput] as FDataset).datasetName;
  final code = '''
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
    isRequired: true,
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
    isRequired: true,
    endsWithComma: false,
  )}
          }
          return true;
        },
          child: ListView.builder(
            $_scrollDirection
            reverse: $reverse,
            physics: ${CS.physic(context, node.body)},
            shrinkWrap: $shrinkWrap,
            itemCount: this.datasets['$dataset'].length > 0 ? this.datasets['$dataset'].length : 0,
            itemBuilder: (context, index) {
              return $childString;
            },
          ),
        )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    final code = await listViewBuilderCodeTemplate(
      context,
      node,
      pageId,
      null,
      loop,
    );
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }
}

// ignore: unused_element
Widget _example() {
  return Builder(
    builder: (final context) {
      final children = <Widget>[];
      return ListView.builder(
        itemCount: children.length,
        itemBuilder: (final context, final index) {
          return children[index];
        },
      );
    },
  );
}
