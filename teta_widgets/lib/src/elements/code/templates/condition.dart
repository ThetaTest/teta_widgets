// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/condition_type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_models/teta_models.dart';

/// Condition Template
class ConditionCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
    final int? loop,
  ) async {
    final condition =
        (body.attributes[DBKeys.conditionType] as FConditionType).get;
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    var value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      whiteSpace: false,
      wrapInString: true,
    );
    if (value.contains('this.datasets[')) {
      value = value.replaceAll('  ', ' ');
    }
    var valueOfCondition =
        (body.attributes[DBKeys.valueOfCondition] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
      whiteSpace: false,
      wrapInString: true,
    );
    if (valueOfCondition.contains('this.datasets[')) {
      valueOfCondition = valueOfCondition.replaceAll('  ', ' ');
    }
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
    var code = '';
    if (condition == ConditionType.equal) {
      code = '''
    ($value == $valueOfCondition) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.notEqual) {
      code = '''
    ($value != $valueOfCondition) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.isNull) {
      code = '''
    ($value == null) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.notNull) {
      code = '''
    ($value != null) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.greaterThan) {
      code = '''
    ((double.tryParse($value) ?? 0) > (double.tryParse($valueOfCondition) ?? 0)) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.greaterOrEqualThan) {
      code = '''
    ((double.tryParse($value) ?? 0) >= (double.tryParse($valueOfCondition) ?? 0)) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.lessThan) {
      code = '''
    ((double.tryParse($value) ?? 0) < (double.tryParse($valueOfCondition) ?? 0)) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.lessOrEqualThan) {
      code = '''
    ((double.tryParse($value) ?? 0) <= (double.tryParse($valueOfCondition) ?? 0)) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.contains) {
      code = '''
    ($value.contains($valueOfCondition)) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.startsWith) {
      code = '''
    ($value.startsWith($valueOfCondition)) ? $childIfTrue : $childIfFalse
  ''';
    } else if (condition == ConditionType.endsWith) {
      code = '''
    ($value.endsWith($valueOfCondition)) ? $childIfTrue : $childIfFalse
  ''';
    }
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
