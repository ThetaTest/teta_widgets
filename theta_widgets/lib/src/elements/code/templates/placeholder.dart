// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for Placeholder widget
class PlaceholderCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final strokeWidth = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.double,
      defaultValue: '2.0',
    );
    final fill = FFill.toCode(
      body.attributes[DBKeys.fill] as FFill,
      context,
      flagConst: false,
    );
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Placeholder(
      strokeWidth: $strokeWidth,
      $fill
      fallbackWidth: ${(body.attributes[DBKeys.width] as FSize).size},
      fallbackHeight: ${(body.attributes[DBKeys.height] as FSize).size},
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.placeholder),
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
    group('Placeholder toCode test', () {
      test(
        'Placeholder: default',
        () {
          final body = NodeBody.get(NType.placeholder);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final strokeWidth = abstract.toCode(
            0,
            resultType: ResultTypeEnum.double,
            defaultValue: '2.0',
          );
          final fill = FFill.toCodeTests(FFill().ready(FFillType.solid));
          expect(
            FormatterTest.format('''
             Placeholder(
              strokeWidth: $strokeWidth,
              $fill
              fallbackWidth: ${(body.attributes[DBKeys.width] as FSize).size},
              fallbackHeight: ${(body.attributes[DBKeys.height] as FSize).size},
              child: const SizedBox(),
              )
             '''),
            true,
          );
        },
      );
    });
  }
}
