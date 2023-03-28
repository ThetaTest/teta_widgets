import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:theta_models/theta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import '../../snippets/update_state_value.dart';
import 'params.dart';

class TAStateIncrement extends TetaAction {
  TAStateIncrement({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStateIncrement.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStateIncrementParams.fromJson(
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
  TAStateIncrementParams get params => super.params as TAStateIncrementParams;

  @override
  TetaActionType get type => TetaActionType.stateIncrement;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    try {
      final index = state.states
          .indexWhere((final element) => element.name == params.stateName);
      if (double.tryParse(
            state.states[index].value as String? ??
                state.states[index].defaultValue!,
          ) !=
          null) {
        final value = double.parse(
          state.states[index].value as String? ??
              state.states[index].defaultValue!,
        );
        updateStateValue(
          context,
          params.stateName!,
          '${value + 1}',
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    final variable = takeStateFrom(page, '${params.stateName}');
    if (variable == null || params.stateName == null) return '';

    final varName = ReCase(params.stateName!).camelCase;

    if (variable.type == VariableType.string) {
      return '''
    if (double.tryParse($varName) != null) { 
      setState(() {
        $varName = '\${double.parse($varName) + 1}';
      });
    }''';
    } else if (variable.type == VariableType.int) {
      return '''
    if (int.tryParse($varName) != null) { 
      setState(() {
        $varName++';
      });
    }''';
    } else if (variable.type == VariableType.double) {
      return '''
    if (double.tryParse($varName) != null) { 
      setState(() {
        $varName++';
      });
    }''';
    } else {
      return '';
    }
  }
}
