// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Code Template of Text Node
class TextCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final maxLines =
        (body.attributes[DBKeys.maxLines] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '1',
    );
    final code = '''
    Text(
      $value,
      ${CS.textStyle(context, body, DBKeys.textStyle)}
      ${maxLines != '0' ? 'maxLines: $maxLines' : ''}
    )
  ''';
    Logger.printWarning(code);
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    return FormatterTest.format(
      await toCode(
        context,
        NodeBody.get(NType.text),
        0,
      ),
    );
  }

  static void testCode() {
    group('Text toCode test', () {
      test(
        'Text: default code',
        () {
          final body = NodeBody.get(NType.text);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final value = abstract.toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format('''
              Text($value)
            '''),
            true,
          );
        },
      );
    });
  }
}
