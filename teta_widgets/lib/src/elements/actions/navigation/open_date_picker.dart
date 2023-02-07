// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recase/recase.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';

// Project imports:

class FActionNavigationOpenDatePicker {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final String? stateName,
  ) async {
    if (stateName == null) return;
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
    var value = '';
    if (datePicked != null && hourPicked != null) {
      final dateToPass = DateTime(
        datePicked.year,
        datePicked.month,
        datePicked.day,
        hourPicked.hour,
        hourPicked.minute,
      );
      value = dateToPass.toIso8601String();
    } else if (datePicked != null && hourPicked == null) {
      value = datePicked.toIso8601String();
    } else {
      value = '';
    }
    updateStateValue(context, stateName, value);
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

  static void testActionCode() {
    group('OpenBottomSheet Action ToCode Test', () {
      test(
        'OpenBottomSheet',
        () {
          expect(
            FormatterTest.format('''
         GestureDetector(
           onTap: () async {
             final datePicked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015, 8),
                lastDate: DateTime(2101),);
             const initialTime = TimeOfDay(hour: 0, minute: 0);
             final hourPicked = await showTimePicker(
                context: context,
                initialTime: initialTime,);
           },
           child: const SizedBox(),
           )
            '''),
            true,
          );
        },
      );
    });
  }
}
