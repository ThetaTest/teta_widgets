// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

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
String listViewBuilderCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  final _scrollDirection =
      !(body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : '';
  final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;
  final reverse = body.attributes[DBKeys.isFullWidth] as bool;
  final childString = child != null ? child.toCode(context) : '';
  final dataset =
      (body.attributes[DBKeys.datasetInput] as FDataset).datasetName;
  return '''
    Builder(
      builder: (context) {
        return ListView.builder(
          $_scrollDirection
          reverse: $reverse,
          physics: ${CS.physic(context, body)},
          shrinkWrap: $shrinkWrap,
          itemCount: this.datasets['$dataset'].length > 0 ? this.datasets['$dataset'].length : 0,
          itemBuilder: (context, index) {
            return $childString;
          },
        );
      },
    )
  ''';
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
