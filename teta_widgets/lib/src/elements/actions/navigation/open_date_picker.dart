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
    states[index].value =
        '${datePicked?.toIso8601String().substring(0, 10)} ${hourPicked!.hour.toString().padLeft(2, '0')}:${hourPicked.minute.toString().padLeft(2, '0')}';
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
    $name = '\${datePicked?.toIso8601String().substring(0, 10)} \${hourPicked!.hour.toString().padLeft(2, '0')}:\${hourPicked.minute.toString().padLeft(2, '0')}';
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
