// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// FractionallySizedBox Template
class FractionallySizedBoxCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final widthFactor = CS.size(context, body, isWidth: true);
    final heightFactor = CS.size(context, body, isWidth: false);
    if (widthFactor.isEmpty && heightFactor.isEmpty) {
      return CS.child(
        context,
        child,
        comma: false,
        withChild: false,
      );
    }
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    FractionallySizedBox(
      $widthFactor
      $heightFactor
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const FractionallySizedBox()';
    }
  }

  static void testCode() {
    group('FractionallySizedBox toCode test', () {
      test(
        'FractionallySizedBox: default code',
        () {
          expect(
            FormatterTest.format('''
            FractionallySizedBox(
             widthFactor: 1,
             heightFactor: 1,
             child: const FractionallySizedBox()
            )
            '''),
            true,
          );
        },
      );
    });
  }
}
