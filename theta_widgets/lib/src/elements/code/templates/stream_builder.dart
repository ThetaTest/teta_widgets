// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

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
      .from($from)
      .order($order)
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
      final code = await toCode(
        context,
        NodeBody.get(NType.supabaseStreamBuilder),
        [],
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

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'SupabaseStreamBuilder';
    final nodeBody = NodeBody.get(NType.supabaseStreamBuilder);
    final codeToRun = await toCode(
      context,
      nodeBody,
      [],
      0,
    );
    final returnValue = FormatterTest.format(
      codeToRun,
    );
    if (!returnValue) {
      Logger.printError(
        'Runtime ToCode Default Error:\n$name\nThis was the code:\n',
      );
      Logger.printWarning(codeToRun);
      Logger.printMessage('\n-----------END-----------');
    } else {
      Logger.printSuccess('$name: Passed!');
    }
    return returnValue;
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
      .from($from)
      .order($order)
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
