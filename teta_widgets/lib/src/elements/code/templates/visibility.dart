import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Visibility widget
class VisibilityCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.bool,
    );
    final visibility = value == 'true' ? 'true' : 'false';

    if (visibility == 'true') {
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
    Visibility(
      visible: $visibility,
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final defaultCode = await toCode(
        context,
        NodeBody.get(NType.visibility),
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
        NodeBody.get(NType.visibility),
        null,
        0,
      ),
    );
  }

  static void testCode() {
    group('Visibility toCode test', () {
      test(
        'Visibility: default code',
        () {
          final body = NodeBody.get(NType.visibility);
          body.attributes[DBKeys.value] = FTextTypeInput(value: 'false');
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final defaultValue = abstract.toCode(0);
          expect(
            FormatterTest.format('''
            Visibility(
             visible: $defaultValue,
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
