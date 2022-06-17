// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
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
    final datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    const initialTime = TimeOfDay(hour: 0, minute: 0);
    final hourPicked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (datePicked != null && hourPicked != null) {
      final dateToPass = DateTime(
        datePicked.year,
        datePicked.month,
        datePicked.day,
        hourPicked.hour,
        hourPicked.minute,
      );
      states[index].value = dateToPass.toIso8601String();
    } else if (datePicked != null && hourPicked == null) {
      states[index].value = datePicked.toIso8601String();
    } else {
      states[index].value = '';
    }
  }

  static String toCode(
    final BuildContext context,
    final String? stateName,
  ) {
    try {
      final reName = ReCase(stateName!);
      final name = reName.camelCase.replaceAll(' ', '');
      return '''
    final datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    const initialTime = TimeOfDay(hour: 0, minute: 0);
    final hourPicked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (datePicked != null && hourPicked != null) {
      final dateToPass = DateTime(
        datePicked.year,
        datePicked.month,
        datePicked.day,
        hourPicked.hour,
        hourPicked.minute,
      );
      $name = dateToPass.toIso8601String();
    } else if (datePicked != null && hourPicked == null) {
      $name = datePicked.toIso8601String();
    } else {
      $name = '';
    }
    ''';
    } catch (e) {
      return '''
    final datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    const initialTime = TimeOfDay(hour: 0, minute: 0);
    final hourPicked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
''';
    }
  }
}
