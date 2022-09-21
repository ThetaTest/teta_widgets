// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// FittedBox Template
class FittedBoxCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    FittedBox(
      fit: BoxFit.contain,
      $childString
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
    group('FittedBox toCode test', () {
      test(
        'FittedBox: default code',
        () {
          const childString = 'const SizedBox()';
          expect(
            FormatterTest.format('''
            FittedBox(
              fit: BoxFit.contain,
              child: $childString   
            )
            '''),
            true,
          );
        },
      );
    });
  }
}
