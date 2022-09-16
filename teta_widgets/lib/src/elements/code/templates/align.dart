// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Align widget
class AlignCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final align = CS.align(body);
    if (align.isEmpty) {
      return CS.child(
        context,
        child,
        comma: false,
        withChild: false,
      );
    }
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Align(
      ${CS.align(body)}
      $childString
    )
  ''';
    final result = FormatterTest.format(code);
    if (result) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.align),
        null,
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
    group('Alignment toCode test', () {
      test(
        'Alignment: null',
        () {
          final body = NodeBody.get(NType.align);
          body.attributes[DBKeys.align] = FAlign(align: null);
          expect(
            FormatterTest.format('''
            Align(
              ${CS.align(body)}
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
      test(
        'Alignment: default',
        () {
          final body = NodeBody.get(NType.align);
          body.attributes[DBKeys.align] = FAlign();

          expect(
            FormatterTest.format('''
            Align(
              ${CS.align(body)}
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
    });
  }
}
