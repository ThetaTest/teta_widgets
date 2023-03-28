// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for Hero widget
class HeroCodeTemplate {
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
    if (value.isEmpty) {
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
  Hero(
    tag: $value,
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

  static void testCode() {}
}
