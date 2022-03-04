// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FCondition {
  static String toCode(
    BuildContext context,
    bool withCondition,
    FTextTypeInput? condition,
    FTextTypeInput? valueOfCondition,
  ) {
    if (withCondition != true) return '';
    if (condition == null || valueOfCondition == null) return '';
    var condStr = condition.toCode(0);
    if (!condStr.contains("'''")) {
      condStr = "'''$condStr'''";
    }
    var condVStr = valueOfCondition.toCode(0);
    if (!condVStr.contains("'''")) {
      condVStr = "'''$condStr'''";
    }
    return '''
    if ($condStr != $condVStr) {
        return;
    }
    ''';
  }
}
