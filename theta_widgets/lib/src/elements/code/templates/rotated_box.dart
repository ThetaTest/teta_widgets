// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import 'package:theta_widgets/teta_open_classes/lib/src/nodes/enum.dart';
import 'package:theta_widgets/teta_open_classes/lib/src/nodes/node.dart';
import 'package:theta_widgets/teta_open_classes/lib/src/nodes/node_body.dart';

/// RotatedBox Template
class RotatedBoxCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final rotation = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '1',
    );

    if (rotation == '1') {
      return CS.child(
        context,
        child,
        comma: false,
        withChild: false,
      );
    }

    final childString = await CS.child(context, child, comma: true);
    final code = '''
    RotatedBox(
      quarterTurns: $rotation,
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
    group('RotatedBox toCode test', () {
      test(
        'RotatedBox: default code',
        () {
          final body = NodeBody.get(NType.rotatedBox);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final rotation = abstract.toCode(
            0,
            resultType: ResultTypeEnum.int,
            defaultValue: '1',
          );
          const childString = 'const SizedBox()';
          expect(
            FormatterTest.format('''
           RotatedBox(
            quarterTurns: $rotation,
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
