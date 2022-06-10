// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:

class FActionNavigationOpenDatePicker {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
    final int? loop,
  ) async {
    final index =
        states.indexWhere((final element) => element.name == stateName);
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    states[index].value = '${picked?.toIso8601String().substring(0, 10)}';
  }

  static String toCode(
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) {
    return '''
    ''';
  }
}
