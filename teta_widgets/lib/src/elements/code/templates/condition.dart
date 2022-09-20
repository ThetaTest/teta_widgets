// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Condition Template
class ConditionCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final valueOfCondition =
        (body.attributes[DBKeys.valueOfCondition] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    var childIfTrue = 'const SizedBox()';
    if (children.isNotEmpty) {
      childIfTrue = (await CS.child(context, children.first, comma: false))
          .replaceFirst('child:', '');
    }
    var childIfFalse = 'const SizedBox()';
    if (children.isNotEmpty && children.length > 1) {
      childIfFalse = (await CS.child(context, children.last, comma: false))
          .replaceFirst('child:', '');
    }
    final code = '''
    (($value) == $valueOfCondition) ? $childIfTrue : $childIfFalse
  ''';
    Logger.printMessage(code);
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = '(true) ? $childIfTrue : $childIfFalse';
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }
  }

  static void testCode() {}
}
