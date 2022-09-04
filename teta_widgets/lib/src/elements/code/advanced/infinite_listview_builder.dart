// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
Future<String> infiniteListViewCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
) async {
  final _scrollDirection = !(body.attributes[DBKeys.isVertical] as bool)
      ? 'scrollDirection: Axis.vertical,'
      : '';
  final code = '''
    Builder(
      builder: (context) {
        final children = <Widget>[${CS.flatChildren(context, children)}];
        return ListView.builder(
          $_scrollDirection
          itemCount: children.length,
          itemBuilder: (context, index) {
            return children[index];
          },
        );
      },
    );
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return 'const SizedBox()';
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
