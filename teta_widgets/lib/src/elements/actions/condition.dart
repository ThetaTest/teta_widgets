// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FCondition {
  static String toCode(
    final BuildContext context,
    final FTextTypeInput? condition,
    final FTextTypeInput? valueOfCondition,
    final String function, {
    required final bool withCondition,
  }) {
    if (withCondition != true) return function;
    if (condition == null || valueOfCondition == null) return function;
    var condStr = condition.toCode(
      0,
      resultType: ResultTypeEnum.string,
    );
    if (!condStr.contains("'''")) {
      condStr = "'''$condStr'''";
    }
    var condVStr = valueOfCondition.toCode(
      0,
      resultType: ResultTypeEnum.string,
    );
    if (!condVStr.contains("'''")) {
      condVStr = "'''$condStr'''";
    }
    return '''
    if ($condStr == $condVStr) {
        return $function
    }
    ''';
  }
}
