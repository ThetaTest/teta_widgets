// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/src/utils/expression/expression.dart';

class FMargins {
  FMargins({
    this.margins,
  }) {
    margins ??= ['0', '0', '0', '0'];
  }

  List<String>? margins;

  EdgeInsets get(BuildContext context) {
    final left =
        MathExpression.parse(context: context, expression: margins![0]);
    final top = MathExpression.parse(context: context, expression: margins![1]);
    final right =
        MathExpression.parse(context: context, expression: margins![2]);
    final bottom =
        MathExpression.parse(context: context, expression: margins![3]);
    return EdgeInsets.only(
      left: double.tryParse(left) != null ? double.parse(left) : 0,
      top: double.tryParse(top) != null ? double.parse(top) : 0,
      right: double.tryParse(right) != null ? double.parse(right) : 0,
      bottom: double.tryParse(bottom) != null ? double.parse(bottom) : 0,
    );
  }

  List<String> getList(BuildContext context) {
    return margins!;
  }

  static FMargins fromJson(List<dynamic> json) {
    try {
      return FMargins(
        margins: json.cast<String>(),
      );
    } catch (e) {
      return FMargins();
    }
  }

  List<String> toJson() {
    return margins!;
  }

  List<String> update({
    required List<String> value,
    required BuildContext context,
  }) {
    return value;
  }

  static String convertToCode(List<String>? list) {
    return '["${list?[0]}","${list?[1]}","${list?[2]}","${list?[3]}"]';
  }

  String toCode(BuildContext context) {
    final left =
        MathExpression.parse(context: context, expression: margins![0]);
    final top = MathExpression.parse(context: context, expression: margins![1]);
    final right =
        MathExpression.parse(context: context, expression: margins![2]);
    final bottom =
        MathExpression.parse(context: context, expression: margins![3]);
    if (double.tryParse(left) == null &&
        double.tryParse(top) == null &&
        double.tryParse(right) == null &&
        double.tryParse(bottom) == null) return '';
    if (double.tryParse(left) == 0 &&
        double.tryParse(top) == 0 &&
        double.tryParse(right) == 0 &&
        double.tryParse(bottom) == 0) {
      return 'EdgeInsets.zero';
    }
    return '''
    const EdgeInsets.only(
      ${double.tryParse(left) != null && double.tryParse(left) != 0 ? "left: ${margins![0]}," : ""}
      ${double.tryParse(top) != null && double.tryParse(top) != 0 ? "top: ${margins![1]}," : ""}
      ${double.tryParse(right) != null && double.tryParse(right) != 0 ? "right: ${margins![2]}," : ""}
      ${double.tryParse(bottom) != null && double.tryParse(bottom) != 0 ? "bottom: ${margins![3]}," : ""}
    )''';
  }

  /*toCode() =>
      "FMargins(margins: [${convertToCode(margins?[0])},${convertToCode(margins?[1])},${convertToCode(margins?[2])}])";*/
}
