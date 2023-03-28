// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Stack Template
class StackCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
  ) async {
    final childrenString = await CS.children(context, children);
    final code = '''
    Stack(
      $childrenString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {
    group('Stack toCode test', () {
      test(
        'Stack: default code',
        () {
          expect(
            FormatterTest.format('''
            Stack(
              childrens: []
            )'''),
            true,
          );
        },
      );
    });
  }
}
