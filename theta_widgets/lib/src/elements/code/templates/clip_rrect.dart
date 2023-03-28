// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// ClipRRect Template
class ClipRRectCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    if (child == null) return 'const SizedBox()';
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    ClipRRect(
      ${CS.borderRadius(context, body)}
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
    group('ClipRRect toCode test', () {
      test(
        'ClipRRect: default code',
        () {
          final body = NodeBody.get(NType.clipRoundedRect);
          final br = body.attributes[DBKeys.borderRadius] as FBorderRadius;
          const child = 'const SizedBox()';
          expect(
            FormatterTest.format('''
              ClipRRect(
               ${br.toCode() != '' ? "borderRadius: ${br.toCode()}," : ''}
               child: $child,
              )
            '''),
            true,
          );
        },
      );
      test(
        'ClipRRect: values code',
        () {
          final body = NodeBody.get(NType.clipRoundedRect);
          final br = body.attributes[DBKeys.borderRadius] as FBorderRadius
            ..radius = [10, 10, 10, 10];
          const child = 'const SizedBox()';
          expect(
            FormatterTest.format('''
              ClipRRect(
               ${br.toCode() != '' ? "borderRadius: ${br.toCode()}," : ''}
               child: $child,
              )
            '''),
            true,
          );
        },
      );
    });
  }
}
