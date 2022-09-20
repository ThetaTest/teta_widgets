// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Opacity widget
class OpacityCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final opacity = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.double,
      defaultValue: '1',
    );
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Opacity(
      opacity: $opacity,
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.opacity),
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
    group('Opacity toCode test', () {
      test(
        'Opacity: default code',
        () {
          final body = NodeBody.get(NType.opacity);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final value = abstract.toCode(0);
          final opacity =
              double.tryParse(value) != null ? double.parse(value) : '1';
          const childString = 'const SizedBox()';
          expect(
            FormatterTest.format('''
            Opacity(
              opacity: $opacity,
              $childString
            )
            '''),
            true,
          );
        },
      );
    });
  }
}
