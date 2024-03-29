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

/// Generates the code for FeatherIcon widget
class IconFeatherCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final CNode? child,
    final int? loop,
  ) async {
    final icon = node.body.attributes[DBKeys.featherIcon] as String;
    final fill = FFill.toCode(
      node.body.attributes[DBKeys.fill] as FFill,
      context,
      flagConst: false,
    );
    final code = '''
    Icon (
      FeatherIconsMap['$icon'],
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
        NodeBody.get(NType.featherIcon),
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
    group('IconFeather toCode test', () {
      test(
        'IconFeather: default',
        () {
          final body = NodeBody.get(NType.featherIcon);
          final icon = body.attributes[DBKeys.featherIcon] as String;
          final fill = FFill.toCodeTests(FFill().ready(FFillType.solid));
          expect(
            FormatterTest.format('''
              Icon (
                FeatherIconsMap['$icon'],
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
