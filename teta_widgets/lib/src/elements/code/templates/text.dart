// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
    final value = abstract.toCode(loop);
    final valueMaxLines =
        (body.attributes[DBKeys.maxLines] as FTextTypeInput).toCode(loop);
    final maxLines =
        int.tryParse(valueMaxLines) != null ? int.parse(valueMaxLines) : '';
    final code = '''
    Text(
      ${abstract.type == FTextTypeEnum.text ? "r$value" : value},
      ${CS.textStyle(context, body, DBKeys.textStyle)}
      ${maxLines != '' ? 'maxLines: $maxLines' : ''}
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final defaultCode = await toCode(
        context,
        NodeBody.get(NType.text),
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
          final value = abstract.toCode(0);
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
