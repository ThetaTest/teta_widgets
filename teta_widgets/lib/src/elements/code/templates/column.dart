// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Column Widget
class ColumnCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
  ) async {
    final childrenString = await CS.children(context, children);
    final code = '''
    Column(
      ${CS.mainAxisAlignment(context, body)}
      ${CS.mainAxisSize(context, body)}
      ${CS.crossAxisAlignment(context, body)}
      $childrenString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(context, body, []);
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        final code = await toCode(
          context,
          NodeBody.get(NType.column),
          children,
        );
        final res = FormatterTest.format(code);
        if (res) {
          return code;
        } else {
          return 'Column(children: [])';
        }
      }
    }
  }

  static void testCode() {
    group('Column toCode test', () {
      test(
        'Column: default',
        () {
          expect(
            FormatterTest.format('''
            Column(children: [])'''),
            true,
          );
        },
      );
    });
  }
}
