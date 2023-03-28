// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for Center widget
class CenterCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Center(
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return toCode(context, body, null);
    }
  }

  static void testCode() {
    group('Center toCode test', () {
      test(
        'Center: null child',
        () {
          expect(
            FormatterTest.format('''
            Center()'''),
            true,
          );
        },
      );
      test(
        'Center: with child',
        () {
          expect(
            FormatterTest.format('''
            Center(
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
    });
  }
}
