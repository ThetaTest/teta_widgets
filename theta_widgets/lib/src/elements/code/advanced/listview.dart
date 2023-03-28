// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for ListView widget
class ListViewCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final int pageId,
    final List<CNode> children,
    final int? loop,
  ) async {
    final reverse = node.body.attributes[DBKeys.isFullWidth] as bool;
    final primary = node.body.attributes[DBKeys.isPrimary] as bool;
    final _scrollDirection =
        !(node.body.attributes[DBKeys.isVertical] as bool? ?? false)
            ? 'scrollDirection: Axis.horizontal,'
            : '';
    final childrenString = await CS.children(context, children);
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
          child: ListView(
        reverse: $reverse,
        primary: $primary,
        physics: ${CS.physic(context, node.body)},
        $_scrollDirection
        $childrenString
      ),
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        node,
        pageId,
        [],
        0,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }
  }

  static void testCode() {
    group('ListView toCode test', () {
      test(
        'ListView: default',
        () {
          final body = NodeBody.get(NType.listView);
          final reverse = body.attributes[DBKeys.isFullWidth] as bool;
          final primary = body.attributes[DBKeys.isPrimary] as bool;
          final _scrollDirection =
              !(body.attributes[DBKeys.isVertical] as bool? ?? false)
                  ? 'scrollDirection: Axis.horizontal,'
                  : '';
          const childrenString = 'children: [],';
          expect(
            FormatterTest.format('''
            ListView(
              reverse: $reverse,
              primary: $primary,
              physics: const AlwaysScrollableScrollPhysics(),
              $_scrollDirection
              $childrenString
            )'''),
            true,
          );
        },
      );
    });
  }
}
