import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:theta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:theta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import 'params.dart';

class TAStateChangeWith extends TetaAction {
  TAStateChangeWith({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStateChangeWith.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStateChangeWithParams.fromJson(
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
  TAStateChangeWithParams get params => super.params as TAStateChangeWithParams;

  @override
  TetaActionType get type => TetaActionType.stateChangeWith;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (params.stateName == null) return;
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    final value = runtimeValue ??
        params.valueToChangeWith?.get(
          pageState.params,
          pageState.states,
          pageState.datasets,
          true,
          state.loop,
          context,
        );
    updateStateValue(context, params.stateName!, value);
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    if (params.stateName != null) {
      final page = getPageOnToCode(pageId, context);
      final variable = takeStateFrom(page, params.stateName!);
      if (variable == null || params.valueToChangeWith == null) return '';

      final varName = ReCase(params.stateName!).camelCase;

      final value = params.valueToChangeWith!.toCode(
        loop,
        resultType: variable.type == VariableType.string
            ? ResultTypeEnum.string
            : variable.type == VariableType.int
                ? ResultTypeEnum.int
                : variable.type == VariableType.double
                    ? ResultTypeEnum.double
                    : ResultTypeEnum.bool,
        defaultValue: variable.type == VariableType.string
            ? ''
            : variable.type == VariableType.int
                ? '0'
                : variable.type == VariableType.double
                    ? '0.0'
                    : 'false',
      );

      if (params.isValueDefault) {
        return 'setState(() => $varName = value);';
      }

      final buffer = StringBuffer()..write('');
      //this will be inserted in a onChange (string value) method so this should work like this
      if (variable.type == VariableType.string) {
        if (value.contains(r'${')) {
          buffer.write(
            '$varName = $value;',
          );
        } else {
          buffer.write(
            "$varName = ${value.isNotEmpty ? value : 'value'};",
          );
        }
      } else {
        if (variable.type == VariableType.int) {
          final v = value.replaceAll("'", '');
          Logger.printWarning(v);
          buffer.write(
            '$varName = ${int.tryParse(v) ?? v};',
          );
        } else if (variable.type == VariableType.double) {
          final v = value.replaceAll("'", '');
          buffer.write(
            '$varName = ${double.tryParse(v) ?? v};',
          );
        } else {
          return '';
        }
      }

      return 'setState(() => $buffer);';
    }
    return '';
  }
}
