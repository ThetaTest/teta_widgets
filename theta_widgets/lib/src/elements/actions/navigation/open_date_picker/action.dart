import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recase/recase.dart';
import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/update_state_value.dart';
import 'params.dart';

class TANavigationOpenDatePicker extends TetaAction {
  TANavigationOpenDatePicker({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TANavigationOpenDatePicker.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TANavigationOpenDatePickerParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TANavigationOpenDatePickerParams get params =>
      super.params as TANavigationOpenDatePickerParams;

  @override
  TetaActionType get type => TetaActionType.navigationOpenDatePicker;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (params.stateName == null) return;
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
    updateStateValue(context, params.stateName!, value);
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    try {
      final reName = ReCase(params.stateName!);
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
