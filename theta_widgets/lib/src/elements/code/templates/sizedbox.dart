// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// SizedBox Template
class SizedBoxCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final width = CS.size(context, body, isWidth: true);
    final height = CS.size(context, body, isWidth: false);
    if (width.isEmpty && height.isEmpty) {
      return CS.child(
        context,
        child,
        comma: false,
        withChild: false,
      );
    }
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    SizedBox(
      $width
      $height
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
    group('SizedBox toCode test', () {
      test(
        'SizedBox: default code',
        () {
          expect(
            FormatterTest.format('''
            SizedBox(
             width: 100,
             height: 100,
             child: const SizedBox()
            )
            '''),
            true,
          );
        },
      );
    });
  }
}
