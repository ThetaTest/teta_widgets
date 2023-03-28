// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for FontAwesomeIcon widget
class IconFontAwesomeCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final CNode? child,
    final int? loop,
  ) async {
    final icon = node.body.attributes[DBKeys.faIcon] as String;
    final fill = FFill.toCode(
      node.body.attributes[DBKeys.fill] as FFill,
      context,
      flagConst: false,
    );
    final code = '''
    Icon (
      faIconNameMapping['$icon'],
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
        NodeBody.get(NType.fontAwesomeIcon),
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
    group('FontAwesome toCode test', () {
      test(
        'FontAwesome: default',
        () {
          final body = NodeBody.get(NType.fontAwesomeIcon);
          final icon = body.attributes[DBKeys.faIcon] as String;
          final fill = FFill.toCodeTests(FFill().ready(FFillType.solid));
          expect(
            FormatterTest.format('''
              Icon (
                faIconNameMapping['$icon'],
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
