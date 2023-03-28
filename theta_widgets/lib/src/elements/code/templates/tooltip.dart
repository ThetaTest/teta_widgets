// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for Tooltip widget
class TooltipCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Tooltip(
      message: $value,
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final defaultCode = await toCode(
        context,
        NodeBody.get(NType.tooltip),
        null,
        0,
      );
      return defaultCode;
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    return FormatterTest.format(
      await toCode(
        context,
        NodeBody.get(NType.tooltip),
        null,
        0,
      ),
    );
  }

  static void testCode() {
    group('Tooltip toCode test', () {
      test(
        'Tooltip: default code',
        () {
          final body = NodeBody.get(NType.tooltip);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final value = abstract.toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format('''
         Tooltip(
           message: $value,
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
