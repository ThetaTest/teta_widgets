// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
class PaddingCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final padding = CS.margin(context, body, isMargin: false);
    if (padding == 'padding: EdgeInsets.zero,') {
      final code = await CS.child(
        context,
        child,
        comma: false,
        withChild: false,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Padding(
      ${padding != '' ? padding : "padding: EdgeInsets.zero,"}
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
    group('Padding toCode test', () {
      test(
        'Padding: default code',
        () {
          final body = NodeBody.get(NType.padding);
          final margins = body.attributes[DBKeys.padding] as FMargins;
          const child = 'const SizedBox()';
          expect(
            FormatterTest.format('''
              Padding(
                padding: ${margins.toCodeForTests()},
                child: $child
             )
            '''),
            true,
          );
        },
      );
      test(
        'Padding: only code',
        () {
          final body = NodeBody.get(NType.padding);
          final margins = body.attributes[DBKeys.padding] as FMargins
            ..margins = ['10', '10', '0', '9'];
          const child = 'const SizedBox()';
          expect(
            FormatterTest.format('''
              Padding(
                padding: ${margins.toCodeForTests()},
                child: $child
             )
            '''),
            true,
          );
        },
      );
    });
  }
}
