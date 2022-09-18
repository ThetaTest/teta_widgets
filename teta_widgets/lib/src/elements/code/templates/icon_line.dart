// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for LineIcon widget
class IconLineCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final CNode? child,
    final int? loop,
  ) async {
    final icon = node.body.attributes[DBKeys.lineIcon] as String;
    final fill = FFill.toCode(
      node.body.attributes[DBKeys.fill] as FFill,
      context,
      flagConst: false,
    );
    final code = '''
    Icon (
      LineIcons.byName('$icon'),
      ${CS.size(context, body, isWidth: true).replaceAll('width', 'size')}
      $fill
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.lineIcon),
        node,
        null,
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
    group('LineIcons toCode test', () {
      test(
        'LineIcons: default',
        () {
          final body = NodeBody.get(NType.lineIcon);
          final icon = body.attributes[DBKeys.lineIcon] as String;
          final fill = FFill.toCodeTests(FFill().ready(FFillType.solid));
          expect(
            FormatterTest.format('''
            Icon(
               LineIcons.byName('$icon'),
               size: 24,
               $fill
               )'''),
            true,
          );
        },
      );
    });
  }
}
