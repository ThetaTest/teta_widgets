// Flutter imports:
import 'package:flutter/material.dart';
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
  BuildContext context,
  NodeBody body,
  CNode? child,
) {
  final _scrollDirection =
      !(body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : '';
  final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;
  final childString = child != null ? child.toCode(context) : '';
  final dataset =
      (body.attributes[DBKeys.datasetInput] as FDataset).datasetName;
  return '''
    Builder(
      builder: (context) {
        return ListView.builder(
          $_scrollDirection
          shrinkWrap: $shrinkWrap,
          itemCount: ${dataset != null ? """
          datasets.keys.contains('$dataset') ? (datasets['$dataset'] as List<dynamic>).length : 0
          """ : "0"},
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
    builder: (context) {
      final children = <Widget>[];
      return ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) {
          return children[index];
        },
      );
    },
  );
}
