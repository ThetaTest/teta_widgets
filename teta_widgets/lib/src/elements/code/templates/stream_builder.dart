// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for StreamBuilder widget
class StreamBuilderCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
    final int? loop,
  ) async {
    final from =
        (body.attributes[DBKeys.supabaseFrom] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final order =
        (body.attributes[DBKeys.supabaseOrder] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final valueRangeTo =
        (body.attributes[DBKeys.supabaseFromRange] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
    );
    final rangeTo =
        int.tryParse(valueRangeTo) != null ? int.parse(valueRangeTo) : 15;

    var child = 'const SizedBox()';
    if (children.isNotEmpty) {
      child = await children.first.toCode(context);
    }

    final code = '''
    StreamBuilder(
      stream: client
      .from('$from')
      .order('$order')
      .limit($rangeTo)
      .execute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return $child;
      }
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
    group('Supabase Stream Builder toCode test', () {
      test(
        'Supabase Stream Builder: default code',
        () {
          final body = NodeBody.get(NType.supabaseStreamBuilder);
          final from =
              (body.attributes[DBKeys.supabaseFrom] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final order =
              (body.attributes[DBKeys.supabaseOrder] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final valueRangeTo =
              (body.attributes[DBKeys.supabaseFromRange] as FTextTypeInput)
                  .toCode(
            0,
            resultType: ResultTypeEnum.int,
          );
          final rangeTo =
              int.tryParse(valueRangeTo) != null ? int.parse(valueRangeTo) : 15;

          const child = 'const SizedBox()';

          expect(
            FormatterTest.format('''
 StreamBuilder(
      stream: client
      .from('$from')
      .order('$order')
      .limit($rangeTo)
      .execute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return $child;
      }
    )
            '''),
            true,
          );
        },
      );
    });
  }
}
